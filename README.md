# c2asmjs

## Install

    gem install rake
    gem install rexical
    gem install racc

## Build

    rake build
    
## Compile

    rake compile[<filename>]
    
## Run

    rake run[<filename>]
    
For running **samples/sample1.c**: `rake run[samples/sample1.c]`

## Test
    
    rake test[<filename>]
    
## All tests

    rake tests

## Clean

    rake clean
    
## Evolutions possibles
    Gestion d'opérations "dangereuses" à la compilation (générer un warning en cas d'overflow, ...)
    Extensions du langage (type bool <=> i1 en llvm, gérer l'inclusion de fichier, ...)
    Plusieurs return dans une fonction
    
    
    