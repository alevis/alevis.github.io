---
layout:     post
title:      Welcome to My Blog
date:       2019-03-27 15:31:19
author:     Levis Agaba
summary:    Welcome to my blog
categories: jekyll
thumbnail:  heart
tags:
 - welcome
 - to
 - carte
 - noire
---

Welcome to my blog.

I created this blog using the carte noire dark theme for Jekyll by Jacob Tomlinson.
Installing the theme wasn't hard but integrating my bootstrap resume was time consuming mostly because I haven't played around with Jekyl in a while.

Initially, I had planed on hosting my resume on a seperate domain but that turned out not to be appealing to me. I wanted to have all my stuff in one place
so I decided to include it somewhere on the blog. I had toyed with idea of blending it into the dark theme but decided against it. The two themes
balance each other well.  So all I had to do, I thought, was just add a link to the blog's hambuger menu. It turned out to be a little more than that. 

To use the resume's assets I had to create a second 'head.html' for the resume. I named it "res-header.html". I renamed the resume's "index.html" to "resume.html" and transferred 
all header content to "res-head.html". Likewise for "res-footer.html". I then added a link to the resume in "_includes/header.html" and created a "_layout/resume.html"  layout for the resume. "./resume.html" would be the content to this layout. I updated all the links in the resume's header, footer files as well as the resume's main file "./resume.html" and merged all the resume's assets with my blogs'. 

The rest was just customizing "_includes/social_links.html" and editing the resume and adding a few things/sections. I