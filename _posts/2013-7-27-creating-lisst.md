---
title: My Personal Project Recipe
layout: post
summary: The goals that I keep in mind to make sure that my side projects end up being interesting and successful.
---

It's been a while since I took on a development project purely for personal reasons. My last big effort was [excellentresume](https://github.com/qrohlf/excellentresume), a PHP-based system for generating interactive HTML resumes from an XML-based format. It was a fun project that taught me a lot, however I wouldn't really categorize it as a success. I lost interest in the project before I was satisfied with the end result, and I didn't learn as much as I'd hoped about creating RESTful APIs because I never got around to building one for the app. I'd tried too hard to make it reusable and useful for other people, and in the process I sacrificed a lot of simplicity as well as the personality that a resume should have.

With my latest project, [Lisst](http://qrohlf.com/Lisst), I set out to build a great self-hosted list writing app. It would use best practices, look amazing, and have a target audience of exactly one person: me. I wanted to avoid the mistakes that had led to me losing interest in excellentresume, so I decided to build it as an iteration of "Where's Quinn", an existing project that I had created a year ago and had been using continuously since I'd finished it.

<img src="/images/creating-lisst/whereis-old.png" alt="old Where's Quinn site" />
*The old "Where's Quinn" site*

"Where's Quinn" was just a static website with a table of all my adventures, written in html & css and updated by hand. I used it to let my family keep track of when I was off the grid, and as a trip log that I could show to people when they asked what I'd been up to lately. This approach was simple, but it had a big drawback: editing the site required an FTP client and a decent text editor, plus I had to type `<tr>` and `<td>` a half-dozen times just to add one row to the table. 

I had three goals in mind when I started writing Lisst. First, I wanted to dip my toe into web development with Ruby. Second, I wanted to replace "Where's Quinn" with something that I could update easily, from anything with a web browser. Finally, I wanted to challenge myself to build something that was intuitively simple in the same vein as an Apple product or Hemingway novel. This final goal was probably the most ambitious of the three.

<img src="/images/creating-lisst/lisst.png" alt="Lisst at Where's Quinn" />
*"Where's Quinn", now using Lisst*

The result of these goals was a project that I found interesting and rewarding. I had the unfamiliarity of a new language to keep me on my toes and shake up some of my old habits, the challenge of trying to build a web application with as little extraneous code as possible, and the motivation of wanting a replacement for "Where's Quinn" to push me through the development snags. While there were definitely some problems with my original goals - I spent three days trying to use a markdown file as a data store because I thought that a database wouldn't be "simple" enough - I credit the success of the project to those three basic goals. They created the right mix of learning, motivation, and creative opportunity to keep me interested in the project, and the direction that they lent to my work led to a useful end-result. 

I consider Lisst to be my most successful personal project, and I've spent some time thinking about how to translate that success to future endeavors. While it helped that my goals for Lisst were specific, that specificity also makes them hard to apply to other plans. So, I've come up with another set of three goals to use when I plan a side project, to make sure that it will be interesting, useful, and fun:

# 1. Have a use, not a use case.
One of the problems that I had with excellentresume was that I had a general idea of what I wanted it to be used for (an online resume for someone applying to jobs in multiple sectors), but I didn't really *need* that myself, as I was applying exclusively to jobs in the software industry while I was building it. With Lisst, I had a specific site that I used on a weekly basis that I wanted to upgrade with a better, more functional system. This gave me more motivation, more focus, and it helped me differentiate between necessary and extraneous features.

# 2. Pick a new language/system.
I built excellentresume with PHP because I wanted to get experience building web APIs and thought that using a language that was familiar would make learning easier. Instead, it made working on my project feel a lot like the drudgery I was used to doing with PHP, and didn't end up teaching me very much. Using Ruby for the first time for Lisst felt new and exciting, and I got to discover cool features of the language throughout the project. I got to learn an entirely new language, discover a new ecosystem, *and* build something useful. I like Ruby enough that I'd consider using it for my next side project, but even if I do I'll be using a framework other than Sinatra because I think a lot of my motivation for side projects comes from the desire to explore and learn about new things.

# 3. Be ambitious.
While it may not seem like a simple list webapp like Lisst is a particularly ambitious project, it was for me largely because of the goal of simplicity. To that end, I had to implement things I'd never done before like save-as-you-type, a RESTful web interface, and a live demo without a login. Lisst was fun because it was a challenge to build the *best* list webapp I was capable of, and I like challenges. Being ambitious with my goals for the project helped me push myself and learn more in the process. It kept things interesting.

Now that I have a recipe for making sure my side projects are interesting, useful, and informative, I look forward to trying it out on the next one. If you have any interesting goals or ideas that you incorporate when you're planning a personal project, I'd love to hear about them (you can reach me via [@qrohlf](https://twitter.com/qrohlf) or [qr@qrohlf.com](mailto:qr@qrohlf.com)). 
