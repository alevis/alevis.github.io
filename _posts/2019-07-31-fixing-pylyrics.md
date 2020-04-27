---
layout:     post
title:      Fixing PyLyrics
date:       2019-07-30 20:10
summary:    A small bug resulted in the wrong error.
categories: Python, PyPI
thumbnail: cogs
published: true
tags:
 - bug
 - error
 - python
 - package
 - flask
---

`PyLyrics` is a great package for retrieving lyrics. 
It uses `BeautifulSoup` to scrape the lyrics from `lyrics.fandom.com`

`BeautifulSoup` or `bs4` provides;

> Python idioms for iterating, searching, and modifying the parse tree. 

See [here] for more information. 

### Mulyrica
`PyLyrics` is a central part of `Mulyrica`, my lyrics search/sentiment analysis app. I was pretty disappointed when it did not work for some queries.
I thought this was a parsing error but upon inspection, it turned out to be something else entirely. 

### It works! 
`PyLyrics` worked until I tested it on a few songs. 
It returned the following error;

```
ValueError: Song or Singer does not exist or the API does not have the lyrics
```

I checked the website but the lyrics were there. 
So I opened up a debug session to investigate and find out where the error was being thrown. 

#### Source of the __problem__

{% highlight python %}
  @staticmethod
  def getLyrics(singer, song):
    #Replace spaces with _
    singer = singer.replace(' ', '_')
    song = song.replace(' ', '_')
    r = requests.get('http://lyrics.wikia.com/{0}:{1}'.format(singer,song))
    s = BeautifulSoup(r.text)
    #Get main lyrics holder
    lyrics = s.find("div",{'class':'lyricbox'})
    if lyrics is None:
      raise ValueError("Song or Singer does not exist or the API does not have Lyrics")
      return None
    #Remove Scripts
    [s.extract() for s in lyrics('script')]
    #Remove Comments
    comments = lyrics.findAll(text=lambda text:isinstance(text, Comment))
    [comment.extract() for comment in comments]    
    #Remove unecessary tags
    for tag in ['div','i','b','a']:
      for match in lyrics.findAll(tag):
        match.replaceWithChildren()
    #Get output as a string and remove non unicode characters and replace <br> with newlines
    output = str(lyrics).encode('utf-8', errors='replace')[22:-6:].decode("utf-8").replace('\n','').replace'<br/>','\n')
    try:
      return output
    except:
      return output.encode('utf-8')
{% endhighlight %}

specifically

{% highlight python %}
  if lyrics is None:
    raise ValueError("Song or Singer does not exist or the API does not have Lyrics")
    return None
{% endhighlight %}

I quickly did a `print lyrics` and sure enough they showed up in the debugging shell running in my browser
so the problem was further down. 

#### More __hunting__

{% highlight python %}
		artist = form.artist.data
		song = form.song.data
		lyrics = PyLyrics.getLyrics(artist, song)
{% endhighlight %}

This time I got the following error;

{% highlight python %}
		ascii code can't decode byte 0xc3 in position 1245: ordinal not in range(128) in file
		/venv/lib/python2/site/packages/functions.py
{% endhighlight %}

That was on line `96` in `functions.py` under `getLyrics(singer,song)`
{% highlight python %}
		#Remove unecessary tags
		for tag in ['div','i','b','a']:
			for match in lyrics.findAll(tag):
				match.replaceWithChildren()
		#Get output as a string and remove non unicode characters and replace <br> with newlines
		output = str(lyrics).encode('utf-8', errors='replace')[22:-6:].decode("utf-8").replace('\n','').replace('<br/>','\n')
		try:
			return output
		except:
			return output.encode("utf-8")
{% endhighlight %}

I thought `encoding` the lyrics twice didn't make sense so I removed call to the encoding method;
{% highlight python %}
		output = str(lyrics).encode('utf-8', errors='replace')[22:-6:].decode("utf-8").replace('\n','').replace('<br/>','\n')
{% endhighlight %}
New code;
{% highlight python %}
		output = str(lyrics)[22:-6:].decode("utf-8").replace('\n','').replace('<br/>','\n')
{% endhighlight %}

Saved the script and restarted the `flask app` again. 
I now had a situation were queries that had caused problems before were working and a few of 
previously error-free queries were suddenly not working.

Curiously, I tried running all queries under two environments, one used `python2.7` the other 
used `python3.5`. 

It was then that I realized that this was a matter of different versions of python. 
The package was made for and tested only on `python3+`

I quickly seperated what worked for `python3` from what workd for `python2` and everything finally worked. 

{% highlight python %}
  #Python 3
  if sys.version_info.major > 2:
    output = str(lyrics).encode('utf-8', errors='replace')[22:-6:].\
        decode("utf-8").replace('\n','').replace('<br/>','\n')
  else: # Python 2
    output = str(lyrics)[22:-6:].decode("utf-8").replace('\n','').\
        replace('<br/>','\n')
  try:
    return [album, output]
  except:
    return [album, output.encode('utf-8')]
{% endhighlight %}

Happy _pythoning_.

[here]: https://pypi.org/project/beautifulsoup4/