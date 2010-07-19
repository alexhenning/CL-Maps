CL Maps
=======
CL Maps is a small utility I wrote in common lisp to play around with generating and displaying maps; partly for fun and partly for [Civ0](http://github.com/alexhenning/Civ0).

Dependencies
------------
[lispbuilder](http://code.google.com/p/lispbuilder/) (svn version 1489) is used for displaying maps and loading images. There are no other dependencies, and the algorithms themselves are just common lisp.

Algorithms
----------

### The `random-map` Algorithm

Results: Poor

This algorithm randomly assigns each location one of the 13 terrains.

![A disappointing random map.](http://github.com/alexhenning/CL-Maps/raw/master/screenshots/random-map_1.png "A random map")