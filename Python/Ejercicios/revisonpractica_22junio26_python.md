Defining New Functions
A function definition specifies the name of a new function and the sequence of statements that run when the function is called. Here’s an example:

def print_lyrics():
    print("I'm a lumberjack, and I'm okay.")
    print("I sleep all night and I work all day.")
       
def is a keyword that indicates that this is a function definition. The name of the function is print_lyrics. Anything that’s a legal variable name is also a legal function name.

The empty parentheses after the name indicate that this function doesn’t take any arguments.

The first line of the function definition is called the header—the rest is called the body. The header has to end with a colon and the body has to be indented. By convention, indentation is always four spaces. The body of this function is two print statements; in general, the body of a function can contain any number of statements of any kind.

Defining a function creates a function object, which we can display like this:

print_lyrics
       
<function __main__.print_lyrics()>
       
The output indicates that print_lyrics is a function that takes no arguments. __main__ is the name of the module that contains print_lyrics.

Now that we’ve defined a function, we can call it the same way we call built-in functions:

print_lyrics()
       
I'm a lumberjack, and I'm okay.
I sleep all night and I work all day.
       
When the function runs, it executes the statements in the body, which display the first two lines of “The Lumberjack Song.”

Parameters
Some of the functions we have seen require arguments; for example, when you call abs you pass a number as an argument. Some functions take more than one argument; for example, math.pow takes two, the base and the exponent.

Here is a definition for a function that takes an argument:

def print_twice(string):
    print(string)
    print(string)
       
The variable name in parentheses is a parameter. When the function is called, the value of the argument is assigned to the parameter. For example, we can call print_twice like this:

print_twice('Dennis Moore, ')
       
Dennis Moore, 
Dennis Moore, 
       
Running this function has the same effect as assigning the argument to the parameter and then executing the body of the function, like this:

string = 'Dennis Moore, '
print(string)
print(string)
       
Dennis Moore, 
Dennis Moore, 
       
You can also use a variable as an argument:

line = 'Dennis Moore, '
print_twice(line)
       
Dennis Moore, 
Dennis Moore, 
       
In this example, the value of line gets assigned to the parameter string.

Calling Functions
Once you have defined a function, you can use it inside another function. To demonstrate, we’ll write functions that print the lyrics of “The Spam Song”:

Spam, Spam, Spam, Spam,
Spam, Spam, Spam, Spam,
Spam, Spam,
(Lovely Spam, Wonderful Spam!)
Spam, Spam,

We’ll start with the following function, which takes two parameters:

def repeat(word, n):
    print(word * n)
       
We can use this function to print the first line of the song, like this:

spam = 'Spam, '
repeat(spam, 4)
       
Spam, Spam, Spam, Spam, 
       
To display the first two lines, we can define a new function that uses repeat:

def first_two_lines():
    repeat(spam, 4)
    repeat(spam, 4)
        
And then call it like this:

first_two_lines()
        
Spam, Spam, Spam, Spam, 
Spam, Spam, Spam, Spam, 
        
To display the last three lines, we can define another function, which also uses repeat:

def last_three_lines():
    repeat(spam, 2)
    print('(Lovely Spam, Wonderful Spam!)')
    repeat(spam, 2)
        
last_three_lines()
        
Spam, Spam, 
(Lovely Spam, Wonderful Spam!)
Spam, Spam, 
        
Finally, we can bring it all together with one function that prints the whole verse:

def print_verse():
    first_two_lines()
    last_three_lines()
        
print_verse()
        
Spam, Spam, Spam, Spam, 
Spam, Spam, Spam, Spam, 
Spam, Spam, 
(Lovely Spam, Wonderful Spam!)
Spam, Spam,Defining New Functions
A function definition specifies the name of a new function and the sequence of statements that run when the function is called. Here’s an example:

def print_lyrics():
    print("I'm a lumberjack, and I'm okay.")
    print("I sleep all night and I work all day.")
       
def is a keyword that indicates that this is a function definition. The name of the function is print_lyrics. Anything that’s a legal variable name is also a legal function name.

The empty parentheses after the name indicate that this function doesn’t take any arguments.

The first line of the function definition is called the header—the rest is called the body. The header has to end with a colon and the body has to be indented. By convention, indentation is always four spaces. The body of this function is two print statements; in general, the body of a function can contain any number of statements of any kind.

Defining a function creates a function object, which we can display like this:

print_lyrics
       
<function __main__.print_lyrics()>
       
The output indicates that print_lyrics is a function that takes no arguments. __main__ is the name of the module that contains print_lyrics.

Now that we’ve defined a function, we can call it the same way we call built-in functions:

print_lyrics()
       
I'm a lumberjack, and I'm okay.
I sleep all night and I work all day.
       
When the function runs, it executes the statements in the body, which display the first two lines of “The Lumberjack Song.”

Parameters
Some of the functions we have seen require arguments; for example, when you call abs you pass a number as an argument. Some functions take more than one argument; for example, math.pow takes two, the base and the exponent.

Here is a definition for a function that takes an argument:

def print_twice(string):
    print(string)
    print(string)
       
The variable name in parentheses is a parameter. When the function is called, the value of the argument is assigned to the parameter. For example, we can call print_twice like this:

print_twice('Dennis Moore, ')
       
Dennis Moore, 
Dennis Moore, 
       
Running this function has the same effect as assigning the argument to the parameter and then executing the body of the function, like this:

string = 'Dennis Moore, '
print(string)
print(string)
       
Dennis Moore, 
Dennis Moore, 
       
You can also use a variable as an argument:

line = 'Dennis Moore, '
print_twice(line)
       
Dennis Moore, 
Dennis Moore, 
       
In this example, the value of line gets assigned to the parameter string.

Calling Functions
Once you have defined a function, you can use it inside another function. To demonstrate, we’ll write functions that print the lyrics of “The Spam Song”:

Spam, Spam, Spam, Spam,
Spam, Spam, Spam, Spam,
Spam, Spam,
(Lovely Spam, Wonderful Spam!)
Spam, Spam,

We’ll start with the following function, which takes two parameters:

def repeat(word, n):
    print(word * n)
       
We can use this function to print the first line of the song, like this:

spam = 'Spam, '
repeat(spam, 4)
       
Spam, Spam, Spam, Spam, 
       
To display the first two lines, we can define a new function that uses repeat:

def first_two_lines():
    repeat(spam, 4)
    repeat(spam, 4)
        
And then call it like this:

first_two_lines()
        
Spam, Spam, Spam, Spam, 
Spam, Spam, Spam, Spam, 
        
To display the last three lines, we can define another function, which also uses repeat:

def last_three_lines():
    repeat(spam, 2)
    print('(Lovely Spam, Wonderful Spam!)')
    repeat(spam, 2)
        
last_three_lines()
        
Spam, Spam, 
(Lovely Spam, Wonderful Spam!)
Spam, Spam, 
        
Finally, we can bring it all together with one function that prints the whole verse:

def print_verse():
    first_two_lines()
    last_three_lines()
        
print_verse()
        
Spam, Spam, Spam, Spam, 
Spam, Spam, Spam, Spam, 
Spam, Spam, 
(Lovely Spam, Wonderful Spam!)
Spam, Spam,
