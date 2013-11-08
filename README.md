csvtt
=====

CSV to table layout - convert csv to user readable format.

Sample usage: `./csvtt inputFile outputFile

    ,,,
    user1,row1,row2,
    user2,longrow2,row2,
    user4,r2,longrow3,

Will be converted to

    user1 row1     row2
    user2 longrow2 row2
    user4 r2       longrow3

### TODO
More flexiblity, argument parser, etc.
