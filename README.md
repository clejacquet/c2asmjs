# c2asmjs

## Install

    gem install rake
    gem install rexical
    gem install racc

## Build

    rake build
    
## Run

    rake run[<filename>]
    
For running **samples/sample1.c**: `rake run[samples/sample1.c]`

## Clean

    rake clean
    
## Evolutions possibles
    Gestion d'opérations "dangereuses" à la compilation (générer un warning overflow, ...)
    Extensions du langage (type bool <=> i1 en llvm)
    
    
    