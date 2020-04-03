---
title: Secure, Industrial Strength SPA Deploys on AWS
layout: post
summary: Combining AWS primitives for secure and scalable SPA deployments
---

There are a [number](https://medium.com/@omgwtfmarc/deploying-create-react-app-to-s3-or-cloudfront-48dae4ce0af) [of](https://medium.com/@sbuckpesch/setup-aws-s3-static-website-hosting-using-ssl-acm-34d41d32e394) [posts](https://gist.github.com/bradwestfall/b5b0e450015dbc9b4e56e5f398df48ff) out there already describing methods for hosting single page apps (SPAs) like Create-React-App on S3 and Cloudfront. However, I've been unable to find one that gives you all of the properties I consider to be important for a production-grade cloud-based deployment in 2018:

- Edge caching via a high-performance CDN
- End-to-end SSL (data is encrypted between CDN and the origin as well as between the user and the CDN)
- Support for HTML5 routing with correct HTTP status codes
- Served from the apex domain (i.e. https://qrohlf.com, not https://www.qrohlf.com)

This blog post will describe the process of setting up an SSL-enabled AWS single page app deployment which satisfies all the above conditions.

# Overview

Here's a quick preview of how all the pieces fit together for deploying an end-to-end https static site on AWS

1. A *private* S3 bucket holds the files. It is not used for web hosting.
2. A Cloudfront CDN distribution acts as our internet-facing server, with page rules to enable single page routing.
3. An automatically generated origin access identity allows cloudfront to securely talk to S3 over https.
4. DNS is handled via Route 53, which enables a free SSL certificate via ACM.
5. The Alias (AKA cname flattening) feature of Route 53 allows you to configure your apex domain to serve your SPA directly via Cloudfront

Each piece of the architecture is simple, but there are a lot of moving pieces involved in getting it set up correctly. Grab a cup of coffee and dig in.

# 1. Create a S3 Bucket

The first thing you need to do is set up a bucket to hold your static files. You'll need to decide on two things:

1. The AWS region your bucket lives in. This doesn't matter to your end users, since they'll be accessing the site through a Cloudfront distribution. I tend to use `US West (Oregon)`. I'll call this the "bucket region" from now on.
2. The bucket name you want to use. Because of the way the S3 wildcard https cert is configured, this needs to be a dns-safe name that does not include any periods (i.e. logbook-qrohlf-com, NOT logbook.qrohlf.com).

Once you've decided on your region and bucket name, navigate to the [S3 Console](https://s3.console.aws.amazon.com/s3/home) and create a bucket. Name it according to the name you picked, and leave all the other settings at their defaults. Do not set it up as a web endpoint, or grant public access (this will be done in Cloudfront instead).

# 2. Set up DNS in Route 53

Your second step is to get DNS set up for the domain that you want to use for your site. I'm going to assume here that you've already registered a domain name with your preferred registrar (if you need a recommendation, I like [hover](https://hover.com/d4jpMlFg)).

Create a public hosted zone in [Route 53](https://console.aws.amazon.com/route53/home?region=us-east-1#hosted-zones:) for your domain, and then update the nameservers with your registrar to point to the nameservers Route 53 lists for your zone.

# 3. Get a HTTPS certificate using ACM

Before going any further, you'll need to provision a free HTTPS certificate using Amazon Certificate Manager. For this to work automatically, you'll need to have updated your domain's nameservers to point to the Route 53 hosted zone.

Go to the ACM panel and make sure that the `us-east-1` (N. Virginia) region is selected (`us-east-1` is required to use the generated certificate with Cloudfront). Request a new public certificate


# Some notes on the S3 'static hosting option'

Many of the accepted solutions for hosting static websites on S3 rely on the S3 Static Website Hosting functionality. This makes sense in many use cases, but if you're going to put a Cloudfront distribution in front of an S3 Static Hosting Endpoint (i.e. http://qrohlf-com.s3-website-us-west-2.amazonaws.com) it's problematic for two reasons:

1. It prevents you from configuring CloudFront to use HTTPS to communicate with S3 ([documentation](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-https-cloudfront-to-s3-origin.html))
2. It requires duplicated routing configuration between S3 Static Hosting `Index document`/`Error document`, and Cloudfront `Default Root Object`/`Error Pages`

