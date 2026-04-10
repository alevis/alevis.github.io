+++
title = "python comprehensions."
description = "Interesting comprehensions in python."
date = 2025-12-03T13:01:00

[taxonomies]
categories = ["Python", "Tutorial", "Comprehensions"]
tags = ["python", "comprehensions"]
+++

## What is a list comprehension;

According to `wikipedia` a list comprehension 

> is a syntactic construct available in some programming languages for creating a list based on existing lists.  

The general format is;

`list = { output_expressions | variable in input_set, predicate }`

Here are some simple examples
```python
  
  import math
  limit = 1440
  l1 = [x**(1/math.pi) for x in 
       [y for y in range(limit) if y % 3 == 0 and y % 7 == 0]]

```

The resulting list contains some interesting numbers fit for number theory study.

## Interesting Comprehensions in Python

Here's a simple list comprehension

```python
  
  fruits = ["apple","banana","orange","kiwi","guava"]
  gr = ((1+5**0.5)/2)
  def price(fruit):
    return len(fruit)*gr

  prices = [price(fruit) for fruit in fruits]

```

### Applying different functions to elements

You want to have a price setting function for fruit you are selling in you grocery store

```python
  
  import math
  gr = ((1+5**0.5)/2)
  fruits = ["apples","bananas","oranges"]
  operations = [lambda apples: len(apples)**(len(apples)/10), 
                lambda bananas: len(bananas)**(len(bananas)/math.pi),
                lambda oranges: len(oranges)**(len(oranges)/gr)]
  # Set the prices
  prices = [op(fruit) for op, fruit in zip(operations,fruits)]

```

## Automation example 

Suppose you have a list of machines identifiable by their mac address and you want to assign a machine to each user in a userlist. 
Ideally there should be a machine available for every user in the userlist.

```python

  class Machine:
      def __init__(self,mac):
          self.mac_address = mac
          self.uptime = 0

  class User:
      def __init__(self,user_name,user_age):
          self.name = user_name
          self.age = user_age

  machines = [Machine('135-144-255-117-098-023'),
              Machine('123-209-089-023-113-210'),
              Machine('109-209-221-112-213-231')]

  users = [User('Joe',21),User('Kate',25),User('Kevin',17)]

```

### Combining the two

```python

  ums = { machine.mac_address:user.name for machine, user in zip(machines,users) }
  print(ums) # should output a dictionary of mac_address username pairs

```

```python
  
  [{'135-144-255-117-098-023':'Joe'}
  {'123-209-089-023-113-210':'Kate'}]

```

### Modifying the list

We want to capture a user so we assign a user dict value to each mac_address key

```python

    ums = { machine.mac_address:{user.name,user.age} for machine, user in zip(machines,users) }
    print(ums) # should output a dictionary of mac_address user dictionary pairs

```

```python

  [{'135-144-255-117-098-023':{'Joe',21}},
  {'123-209-089-023-113-210':{'Kate',25}},
  {'109-209-221-112-213-231':{'Kevin',17}}]

```


And supposing we now want to filter the list of dictionaries to show only machines (represented by their mac addresses ) assigned to users above a certain age;

```python

    ums = { machine.mac_address:{user.name,user.age} for machine, user in zip(machines,users) if user.age > 18 }
    print(ums) # should show a list of length 2 containing users `Joe(21)` and `Kate(27)

```

```python

  [
    {'135-144-255-117-098-023':{'Joe',21}},
    {'123-209-089-023-113-210':{'Kate',25}}
  ]

```

Happy `coding`.
