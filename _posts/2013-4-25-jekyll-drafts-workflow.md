---
title: My Jekyll Drafts Workflow
layout: post
summary: My solution to writing draft Jekyll posts, using a single git branch.
---
***Edit:*** *[Jekyll 1.1](http://jekyllrb.com/docs/upgrading/) now has a drafts feature which is pretty cool. If you're looking for a nice way to handle drafts in Jekyll, you should probably just upgrade. This method is still valid though, and might be useful to you if you want to use GitHub Pages for hosting your jekyll site, but don't want to have your drafts publicly available until they're published.*

There are quite a few solutions to storing draft posts for a Jekyll blog floating around out there. A quick survey of the top google results for "Jekyll Draft" shows people [setting post dates in the far future](http://tqcblog.com/2012/08/22/jekyll-drafts/), using [extra keys in the YAML front matter](http://blog.pixarea.com/2012/07/draft-posts-in-jekyll), and creating [seperate git branches](https://nolancaudill.com/2011/07/03/my-jekyll-setup/) for each draft.

I've looked at all of these solutions and tried a couple of them, but none of them seemed consistent with the simplicity and elegance that I chose Jekyll for. This led to me rolling my own solution for draft posts.

# Requirements:
I wanted my solution to satisfy the following set of requirements:

- **Preview** - I wanted to be able to preview how my draft would look, both on the homepage index and the individual post page. This means I couldn't just set `published: false` in the YAML header.
- **Same Repo** - I tried using Gist to store my drafts for a while, but I eventually abandoned it because my ideal solution is self-contained within the git repo that holds this blog. I like the idea of being able to clone my repo and have everything associated with my blog in one place.
- **Simple** - I didn't want to use plugins or special scripts when I'm working with my posts. I wanted to keep it as minimalist as possible, with no dependencies other than git and jekyll.
- **Doesn't alter authoring** - I wanted to interfere with the act of authoring a post as little as possible. That meant I didn't want to add any extra YAML front matter keys or have to create a branch for each new post.

# Solution:
Fortunately, git makes it pretty easy to accomplish all of this. I created a new branch called "drafts" in my repo. It's what I have checked out most of the time, and I keep all of my drafts in it. They're stored in the \_posts folder just like normal posts, which lets me preview them with `jekyll --server --auto` while I'm writing a post. I can make checkpoint commits while I'm writing a post to save my work and let me see and roll back my revisions to a post.

## Publishing
When it's time to publish a draft post, I use git's ability to checkout individual files from one branch to another to get the draft into master, than push the changes to my host (I use GitHub to host this blog).

{% highlight bash %}
git checkout master
git checkout drafts _posts/draft-post.md
git commit -am "Publish Draft"
git push
{% endhighlight %}
Note that keeping my drafts in a separate branch only adds one command to the usual sequence needed to publish local changes.

## Merging changes from master
If I've changed something in the master branch, like the css or one of the post layouts, and want to get the drafts branch up-to-date with the changes all I have to do is:
{% highlight bash %}
git checkout drafts
git merge master
{% endhighlight %}
...and my drafts branch is updated with the latest changes from the master branch! Yes, this is all *really* basic git stuff, but that's why it's so great. Git makes keeping the drafts branch up-to-date insanely simple.

# Overview
I've come up a solution for writing draft posts with Jekyll that basic git branching to give me a simple and flexible way to write and preview draft posts. Despite the simplicity, it offers some pretty advanced functionality: Revision history for posts is saved in the commit history for the drafts branch, but doesn't clutter up the master branch. Also, the drafts branch can be pushed to GitHub, letting me edit my drafts anywhere that I can git clone my repo.

I like it because it's simple but powerful, and I think it reflects how the simplest solution is often the best solution.
