---
title: Ruby Whitespace Shenanigans, Hello World Edition
layout: post
summary: A (somewhat silly) post about using Unicode whitespace in Ruby.
---

I recently came across [this article](http://www.rubyinside.com/the-split-is-not-enough-whitespace-shenigans-for-rubyists-5980.html), which highlights an interesting side effect of how ruby supports Unicode special characters. Ruby treats the Unicode non-breaking space (U+00A0) like any other Unicode special character, meaning it can be used for variable and method names. The article illustrates this with the following code snippet:

    def  (  )
          *2
    end
     =4
    puts   

This code outputs 8 when run. It does this by defining a method called `nbsp` (where `nbsp` is actually an instance of U+00A0) which takes an argument `nbspnbsp` and returns `nbspnbsp*2`. It then defines a variable called `nbsp` equal to 4 and prints the result of applying the `nbsp` method to it.

Further Investigation
======================
The author of the above post ends it with a dire warning: 
> Please don't use this in production code or the Ruby gods will come and haunt you in your sleep. 

However, I believe that there is a time and a place for shenanigans, and that it is here and now.
<img src="/images/ruby-whitespace-shenanigans/shenanigans.gif" alt="shenanigans"  class="bordered" />

I decided to take the insanity a bit further and write 'Hello World' using U+00A0 and int-to-char casting: 

          = 1
          =  + 
          =   *  + 
          =    *  
          = 
          [      *(   +  )+  , 
                 =     *    + , 
                 =     *    +    -  , 
                , 
                =        +    ,
            *  +    +  , 
            *    -  *    +   +  , 
               , 
               + +  , 
                , 
            *    ,     + +  , 
            ]
    puts      .map(&:chr).join

That code snippet will output `Hello World` if you save it with utf-8 encoding and run it.

(Since your web browser may or may not want to let you copy and paste this into a text editor with the Unicode intact, I suggest downloading a copy from [this gist](https://gist.github.com/qrohlf/7045823) if you'd like to try running it for yourself).

This isn't anything ground-breaking. You can see a non-whitespace version of the program [here](https://gist.github.com/qrohlf/7046060). I define a variable `one` as the integer literal `1`, then define `two`, `five`, and `ten` using `one`. The program then creates an array of the ASCII integer values representing the characters of "Hello World", expressed mathematically using the variables `one`, `two`, `five`, and `ten`. It uses variable definitions inside the array definition to shorten the process. The final line casts the integer ASCII values of the 'hw' array to ASCII characters, then joins them into a string and prints the string to Stdout.

This is, of course, a very quick-and-dirty proof of concept. I'm sure you could optimize this further with some math to find the greatest common divisors of all the decimal representations of the characters of "Hello World" and reduce the number of arithmetic operators needed to create the array. For now, I'm satisfied to leave it as-is, but if you have a better implementation I'd love to see it. My contact info is in the footer.

But Wait - There's More!
========================
U+00A0 isn't the only unusual and invisible character in Unicode. Other notables include text control characters, as well as a whole host of other non-standard whitespace characters in the U+0080 to U+00A0 range. I think I've done enough damage for now and will leave the exploration of what can (but probably shouldn't) be done with these characters for another time. 

However, I couldn't resist a quick parting gift:

    puts "‮dlroW olleH‭"

is also valid Ruby and will output "Hello World". Here's a [gist](https://gist.github.com/qrohlf/7058074) if you're having trouble running it.

