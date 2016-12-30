class Scanner
macro
    digit             [0-9]
    letter            [a-zA-Z_]
    integer           {digit}+
    float             {digit}+\.{digit}*f?
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
                    return              { [:RETURN, text] }

                    \+\=                { [:ADD_ASSIGN, text] }
                    -\=                 { [:SUB_ASSIGN, text] }
                    \*\=                { [:MUL_ASSIGN, text] }
                    \/\=                { [:DIV_ASSIGN, text] }
                    <<\=                { [:SHL_ASSIGN, text] }
                    >>\=                { [:SHR_ASSIGN, text] }
                    \+\+                { [:INC_OP, text] }
                    \-\-                { [:DEC_OP, text] }
                    <\=                 { [:LE_OP, text] }
                    >\=                 { [:GE_OP, text] }
                    \=\=                { [:EQ_OP, text] }
                    \!\=                { [:NE_OP, text] }

                    \+                  { ['+', text] }
                    -                   { ['-', text] }
                    \*                  { ['*', text] }
                    \/                  { ['/', text] }
                    \!                  { ['!', text] }
                    %                   { [:REM, text] }
                    >>                  { [:SHR, text] }
                    <<                  { [:SHL, text] }
                    <                   { ['<', text] }
                    >                   { ['>', text] }
                    \|\|                { [:OR, text] }
                    &&                  { [:AND, text] }

                    \=                  { ['=', text] }
                    \.                  { ['.', text] }
                    ,                   { [',', text] }
                    ;                   { [';', text] }
                    \{                  { ['{', text] }
                    \}                  { ['}', text] }
                    \(                  { ['(', text] }
                    \)                  { [')', text] }

                    {float}             { [:CONSTANTF, text.to_f] }
                    {integer}           { [:CONSTANTI, text.to_i] }

                    {identifier}        { [:IDENTIFIER, text] }

                    {word}              { puts "Invalid token: #{text}"; [:INVALID_TOKEN, text] }

                    \n|\s
                    .
end