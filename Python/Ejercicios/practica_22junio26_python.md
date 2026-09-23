Python 3.13.11 | packaged by Anaconda, Inc. | (main, Dec 10 2025, 21:21:08) [Clang 20.1.8 ] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> def print_lyrics():
...     print("I'm a lumberjack, and I'm okay")
...     print("I sleep all night and work all day")
...     
>>> print_lyrics()
I'm a lumberjack, and I'm okay
I sleep all night and work all day
>>> print_lyrics
<function print_lyrics at 0x1014a87c0>
>>> def print_twice(string):
...     print(string)
...     print(string)
...     
>>> print_twice('Dennis Moore,')
Dennis Moore,
Dennis Moore,
>>> string = 'Dennis Moore,'
>>> string = 'Dennis Moore,'
>>> print(string)
Dennis Moore,
>>> print(string)
Dennis Moore,
>>> line = 'Dennis Moore,'
>>> print_twice(line)
Dennis Moore,
Dennis Moore,
>>> def repeat(word, n)
  File "<python-input-11>", line 1
    def repeat(word, n)
                       ^
SyntaxError: expected ':'
>>> def repeat(word, n):
...     print(word * 4)
...     
>>> spam = 'Spam'
>>> repeat(line)
Traceback (most recent call last):
  File "<python-input-14>", line 1, in <module>
    repeat(line)
    ~~~~~~^^^^^^
TypeError: repeat() missing 1 required positional argument: 'n'
>>> repeat(spame)
Traceback (most recent call last):
  File "<python-input-15>", line 1, in <module>
    repeat(spame)
           ^^^^^
NameError: name 'spame' is not defined. Did you mean: 'spam'?
>>> repeat(span)
Traceback (most recent call last):
  File "<python-input-16>", line 1, in <module>
    repeat(span)
           ^^^^
NameError: name 'span' is not defined. Did you mean: 'spam'?
>>> def repeat(word, n):
...     print(word *4)
...     
>>> spam = 'Spam'
>>> repeat(spam)
Traceback (most recent call last):
  File "<python-input-19>", line 1, in <module>
    repeat(spam)
    ~~~~~~^^^^^^
TypeError: repeat() missing 1 required positional argument: 'n'
>>> repeat(spam, 4)
SpamSpamSpamSpam
>>> spam = 'Spam, '
>>> repeat(spam, 4)
Spam, Spam, Spam, Spam, 
>>> def firts_two_lines():
...     print(repeat)
...     
>>> 
>>> def first_two_lines():
...     repeat(Spam, 4)
...     repeat(Spam, 4)
...     
>>> first_two_lines
<function first_two_lines at 0x1014a9bc0>
>>> first_two_lines()
Traceback (most recent call last):
  File "<python-input-27>", line 1, in <module>
    first_two_lines()
    ~~~~~~~~~~~~~~~^^
  File "<python-input-25>", line 2, in first_two_lines
    repeat(Spam, 4)
           ^^^^
NameError: name 'Spam' is not defined. Did you mean: 'spam'?
>>> def first_two_lines():
...     repeat(spam, 4)
...     repeat(spam, 4)
...     
>>> first_two_lines()
Spam, Spam, Spam, Spam, 
Spam, Spam, Spam, Spam, 
>>> def last_threee_lines():
...     repeat(spam, 2)
...     print('(Lovely Spam, Wonderful Spam!)'
...     repeat(Spam, 2)
...     
  File "<python-input-30>", line 3
    print('(Lovely Spam, Wonderful Spam!)'
         ^
SyntaxError: '(' was never closed
>>> def last_threee_lines():
...     repeat(spam, 2)
...     print('(Lovely Spam, Wonderful Spam!)')
...     
...     repeat(Spam, 2)
...     
>>> last_threee_lines()
Spam, Spam, Spam, Spam, 
(Lovely Spam, Wonderful Spam!)
Traceback (most recent call last):
  File "<python-input-32>", line 1, in <module>
    last_threee_lines()
    ~~~~~~~~~~~~~~~~~^^
  File "<python-input-31>", line 5, in last_threee_lines
    repeat(Spam, 2)
           ^^^^
NameError: name 'Spam' is not defined. Did you mean: 'spam'?
>>> def last_threee_lines():
...     repeat(spam, 2)
...     print('(Lovely Spam, Wonderful Spam!)')
...     
...     repeat(spam, 2)
...     
>>> last_threee_lines()
Spam, Spam, Spam, Spam, 
(Lovely Spam, Wonderful Spam!)
Spam, Spam, Spam, Spam, 
>>> def print_verse():
...     first_two_lines()
...     last_threee_lines()
...     
>>> print_verse()
Spam, Spam, Spam, Spam, 
Spam, Spam, Spam, Spam, 
Spam, Spam, Spam, Spam, 
(Lovely Spam, Wonderful Spam!)
Spam, Spam, Spam, Spam, 
>>> 

