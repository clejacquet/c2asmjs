class Scanner
macro
    digit             [0-9]
    letter            [a-zA-Z_]
    integer           {digit}+
    float             {digit}+\.{digit}*
    identifier        {letter}({letter}|{digit})*
    word              {letter}+

rule
                    \/\*                { @state = :COMMENT; nil }
                    \/\/.*
    :COMMENT        \*\/                { @state = nil }
    :COMMENT        .|\n                { }

                    double              { [:DOUBLE, text] }
                    float               { [:FLOAT, text] }
                    int                 { [:INT, text] }
                    void                { [:VOID, text] }
                    if                  { [:IF, text] }
                    else                { [:ELSE, text] }
                    while               { [:WHILE, text] }
                    for                 { [:FOR, text] }
                    do                  { [:DO, text] }

                    \+\=                { [:ADD_ASSIGN, text] }
                    -\=                 { [:SUB_ASSIGN, text] }
                    \*\=                { [:MUL_ASSIGN, text] }
                    \/\=                { [:DIV_ASSIGN, text] }

                    \+                  { ['+', text] }
                    -                   { ['-', text] }
                    \*                  { ['*', text] }
                    \/                  { ['/', text] }
                    %                   { ['%', text] }
                    \=                  { ['=', text] }
                    ;                   { [';', text] }

                    {float}             { [:FLOAT_VAL, text.to_f] }
                    {integer}           { [:INT_VAL, text.to_i] }

                    {identifier}        { [:IDENTIFIER, text] }

                    {word}              { puts "Invalid token: #{text}"; [:INVALID_TOKEN, text] }

                    \n|\s
                    .
end