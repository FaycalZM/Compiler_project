/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_SYNTAX_TAB_H_INCLUDED
# define YY_YY_SYNTAX_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PROG = 258,
    L_FOR = 259,
    L_WHILE = 260,
    INPUT = 261,
    OUTPUT = 262,
    IF = 263,
    ELSE = 264,
    DOT = 265,
    COMMA = 266,
    SEMICOLON = 267,
    OPENINGPARENTHESIS = 268,
    CLOSINGPARENTHESIS = 269,
    OPENINGBRACE = 270,
    CLOSINGBRACE = 271,
    OPENINGBRACKET = 272,
    CLOSINGBRACKET = 273,
    EQUAL = 274,
    NONEQUAL = 275,
    AND = 276,
    OR = 277,
    NON = 278,
    INFERIOR = 279,
    SUPERIOR = 280,
    INFERIOREQUAL = 281,
    SUPERIOREQUAL = 282,
    ADD = 283,
    SUB = 284,
    MULT = 285,
    DIV = 286,
    MOD = 287,
    POWER = 288,
    ASSIGN = 289,
    BOOL = 290,
    INTEGER = 291,
    FLOAT = 292,
    INTDEC = 293,
    STRDEC = 294,
    BOOLDEC = 295,
    FLTDEC = 296,
    S = 297,
    INLINECOMMENT = 298,
    NEWLINE = 299,
    STR = 300,
    ID = 301
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 28 "syntax.y"

    int val_int;
    double val_float;
    char val_str[255];

#line 110 "syntax.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_SYNTAX_TAB_H_INCLUDED  */
