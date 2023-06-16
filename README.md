Chess DB
--------

Chess knowledge database

Bugs: Display code doesn't handle PxP e.p. properly
First move not displayed same as subsequent ones. Starting position cannot be returned to.
Once game has exceeded 35 moves, move list is useless as moves appear off-screen. Need to 'scroll' somehow

Right now I have a problem in that I have lots of chess knowledge scattered around various
resources. These include my own games, a large database of master games as well as many books.
These sources of info don't help me with my desire to have 'some opening knowledge' or something
approaching some sort of repertoire.

1. They aren't tailored to me and so contain vast amounts of 'noise'
2. they are incomplete e.g.John Watson's books fail to cover some of the major 
        openings such as the f4 Sicilian (Grand Prix attack) and the Nimzo-Indian both of which 
        are pretty popular.
3. They often don't analyse 'obvious' non-moves to explain why these don't work. I have some literature that does
do this, but the vast majority does not. - Watson seems to be the source of this material.

The plan is as follows:
0. Work out what my requirements are. The below list is very technically-orientated (although 1a is a concern, it has already
been implemented reasonably well - 325k games occupies ~250Mb database storage which is easily trasferred to alice if required
1. Import my existing chess database(s) into a rails database
   
    a. Importing a large database is infeasible - it takes vast amounts of CPU time and disk space
    The current code imports the whole game only when it is looked at (e.g. the 'moves' table is considered 
   to be a cache)
    b. Instead of importing whole game, import just enough moves for opening to be distinct i.e. that this
position is not in the current database. The 'moves' table already has the FEN of the resulting position,
so importing until that is unique should be straight-forward.
2. Show moves and opening names where possible
3. Handle transpositions (c.f. 'Transpo Tricks in Chess')
4. Learn some Javascript libraries e.g. Angular, Backbone in conjunction with rails so that I can understand their strengths and weaknesses
4a. Maybe not Angular or Backbone....
4b. Create chessboard in Elm rather than the above
5. Learn more about testing and test-driving a complex web application
6. Write a blog about the experience.

Here's the attribution for the chess piece images:
By <a href="https://en.wikipedia.org/wiki/User:Cburnett" class="extiw" title="en:User:Cburnett">en:User:Cburnett</a> -
<span class="int-own-work" lang="en">Own work</span><a href="//commons.wikimedia.org/wiki/File:Inkscape-un.svg" title="File:Inkscape-un.svg">
</a>
This W3C-unspecified <a href="https://en.wikipedia.org/wiki/Vector_images" class="extiw" title="w:Vector images">vector image</a>
was created with <a href="https://en.wikipedia.org/wiki/Inkscape" class="extiw" title="w:Inkscape">Inkscape</a>.,
<a href="http://creativecommons.org/licenses/by-sa/3.0/" title="Creative Commons Attribution-Share Alike 3.0">CC BY-SA 3.0</a>,
<a href="https://commons.wikimedia.org/w/index.php?curid=1499810">Link</a>
