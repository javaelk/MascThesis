% UW THESIS (1991) STYLE - see thesis91(7) man page
% Updated to the "Thesis Regulations and Guide," January 1990 format
% and approved by the University Graduate Office.  [August 13, 1990]
%
% Updated for LaTeX2e and extended to allow two-sided typesetting:
%   - chapters, and prepages start on right hand side page (if so
%     requested -- see ``openright'' option),
%   - possibly skipped even numbered pages at the end of chapter are
%     empty
%
% Also added:
%
% Command ``\newPrepageEnvironment'' which is used to define abstracts,
% trademarks, acknowledgements etc. It defines a kind of chapter for
% prepages.
%
% Andrej Brodnik, ABrodnik@UWaterloo.CA, Waterloo February 28\Th, 1995.
%
% Corrections in layout (for detail description of variables see [2,
% pp. 84--87]) and point size:
%
%    o According to [1] 10pt-12pt size fonts are allowed. Thus the
%      warning from the previous version is taken out.
%    o The outer margin for even and odd side pages is the
%      same (it is 1.15 inches as required by [1]).
%    o The text width is 5.85 inches, which leaves for the inner
%      margin 1.5 inch (by [1] it is required 1.125 inch).
%    o The top margin is 1 inch as required by [1].
%    o The height of the text including footnotes is 7.9 inhes, which
%      leaves for the footer and bottom margin 1.1 inches (by [1]
%      required 1 inch). The only footer we have are page counts on
%      the first pages of the chapter and on pre-pages.
%       *changed* see below -akgoel
%
% [1] University Graduate Office. Thesis Regulations. University of
%     Waterloo, June 1994.
% [2] M. Goossens, F. Mittelbach, and A. Samarin. The \LaTeX
%     Companion. Addison-Wesley, Reading, 1994.
%
% Andrej Brodnik, ABrodnik@UWaterloo.CA, Waterloo February 28\Th, 1995.
%---
% Made the following changes during Sept, 1995.
%   . do a slightly better job of setting \baselinestetch
%   . use fancyheadings instead of headings to allow individual
%     customization of running headers.
%
% Anil Goel, akgoel@math.uwaterloo.ca
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis91e}[1995/07/25]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions

\typeout{thesis91e: Waterloo thesis style updated for 1991}
\typeout{thesis91e: with some 1995 modifications.}
\typeout{thesis91e: See the thesis91(7) man page for guidance}
\typeout{thesis91e: and approval etc.}

\LoadClass{report}

%%%%
%
% Layout of the page:
%--------------------

                       % HORIZONTAL DIMENSIONS

   %----------------------------------------------------------------
   % NOTE: change only ``\textwidth'' and ``\evensidemargin'' (which
   %       is also outer margin - 1inch). The other margins are
   %       computed automatically.
   %----------------------------------------------------------------

   % Width of text:
\setlength{\textwidth}{5.85in}
   % Margins:
\setlength{\hoffset}{0pt}               % No horizontal offset, so the
                                        % margin is 1 inch already.
     % even side in two sided document:
\setlength{\evensidemargin}{0.15in}     % has to be added another 0.15in
     % odd sided in two sided document and outer in one sided docment:
\setlength{\oddsidemargin}{\paperwidth}        %    paperwidth
\addtolength{\oddsidemargin}{-1in}             %  - (1 in +    \
                                               %                = outer margin
\addtolength{\oddsidemargin}{-\evensidemargin} %     even side)/
\addtolength{\oddsidemargin}{-\textwidth}      %  - text width
\addtolength{\oddsidemargin}{-1in}             %  - 1 in       = default margin

   % Marginal notes:
\setlength{\marginparwidth}{0.90in}     % Width of marginal notes.
\setlength{\marginparsep}{0.10in}       % space between outer margin and
                                        % marginal note

                        % VERTICAL DIMENSIONS

   % Height of text:
\setlength{\textheight}{7.8in}  % including footnotes and figures,
                                % excluding running head and foot.
   % Margins:
\setlength{\topmargin}{0pt}     % just default 1inch on the top
\setlength{\headheight}{24pt}
\setlength{\headsep}{20pt}
\setlength{\footskip}{36pt}


%%%%
%
% Text formatting:
%-----------------

                           % DOUBLE SPACING

% In the Table 3 on [2, p. 53] are recommended values for double
% spacing of lines depending on the point size. The table is not
% implemented in this code, but the only value we give is the one for
% 11pt which was used in my thesis.



\RequirePackage{setspace}
\addtolength{\footnotesep}{\medskipamount} %

\typeout{thesis91e: Put \ doublespacing in the pre-emble of the main document}

\ifcase \@ptsize \relax % 10pt
    \renewcommand\baselinestretch{1.667}
  \or % 11pt
    \renewcommand\baselinestretch{1.618}
  \or % 12pt
    \renewcommand\baselinestretch{1.655}
  \fi

%%%%
%
% Thesis specific macros:
%---

   % \@clearChapterPage

% Clears the last page of previous chapter (this is also true for
% ``PrepageEnvironment'') and properly positions the first page of the
% next chapter (perhaps skipping even page).

\def\@clearChapterPage{%
  \if@openright\cleardoublepage\else\clearpage \fi
}

%
% at cleardoublepage we don't want the possibly skipped even page to
% be numbered (taken from ``ltoutput.dtx''):
\renewcommand{\cleardoublepage}{%
  \clearpage%
  \if@twoside \ifodd\c@page\else \thispagestyle{empty}
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi%
  \fi\fi%
}


   % PrepageEnvironment

% PrepageEnvironment is used in prepages for abstract,
% acknowledgement etc. The first argument is a name of the new
% environment and the second one the title printed out for it.
%
% The PrepageEnvironment attempts to centre the text vertically on the
% page. If your text approaches or exceeds one page in length, you will
% probably find the title at the bottom of one page, and the text
% itself on the next page. To avoid this, remove the ``\null\vfil'' in
% the beginning and ending part of ``\newenvironment'', and latex
% won't try to centre it on the page.

\newcommand{\newPrepageEnvironment}[2]{
  \@ifundefined{#1}%
     {\let\@tempa=\newenvironment
     }{\let\@tempa=\renewenvironment}
  \@tempa{#1}{
    \@clearChapterPage
    \thispagestyle{plain}
    \null\vfil
    \begin{center} \textbf{\Large #2} \end{center}
  }{\par\vfil\null \clearpage}
}

   % \prepages and \mainbody

\RequirePackage{library/fancyheadings} %modified by Shimin Li 2005 - adding the relative path of fancyheadings.sty
\headrulewidth 0pt
\if@twoside
  \lhead[\fancyplain{}{\thepage}]%
    {\fancyplain{}{ \slshape\rightmark}}
  \rhead[\fancyplain{}{\slshape\leftmark}]%
    {\fancyplain{}{\thepage}}
\else
    \lhead%
        {\fancyplain{}{ \slshape\leftmark}}
    \rhead%
        {\fancyplain{}{\thepage}}
\fi

\cfoot[{}]%
    {\fancyplain{\thepage}{}}



\def\prepages{\pagenumbering{roman}}
\def\mainbody{
  \@clearChapterPage
  \pagenumbering{arabic}
  \pagestyle{fancyplain}
}


%%%%
%
% Special pages of the thesis:
%-----------------------------

                             % TITLE PAGE

\newcommand{\discipline}[1]{\gdef\@discipline{#1}}
\newcommand{\degree}[1]{\gdef\@degree{#1}}
\renewcommand{\maketitle}{%
\begin{titlepage} \setlength{\parindent}{0pt}
  \let\footnotesize\small      % Local definitions to make \thanks produce
  \let\footnoterule\relax      % \normalsize footnotes with no
                               % separating rule.
  \setcounter{page}{1}
  \parbox{\linewidth}{         % Title and author are at the top.
    \begin{center}
      {\LARGE \@title}
    \\[3em]
      {by}
    \\[3em]
      {\large \lineskip .75em
       \begin{tabular}[t]{c} \@author \end{tabular}
      }
    \end{center}
  }

\vfill

  \parbox{\linewidth}{         % what is this thesis for is in the middle,
    \begin{center}
       A thesis
    \\ presented to the University of Waterloo
    \\ in fulfilment of the
    \\ thesis requirement for the degree of
    \\ \@degree
    \\ in
    \\ \@discipline
    \end{center}
  }

\vfill

  \parbox{\linewidth}{         % and place, date, and copyright are
    \begin{center}             % the bottom
       Waterloo, Ontario, Canada, \number\year % Place & date
    \\[3em]
       \copyright\@author\ \number\year
    \end{center}
  }

  \@thanks
\end{titlepage}
  \setcounter{footnote}{0}       % Footnotes start at zero again.
  \let\thanks\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\let\maketitle\relax
}% \maketitle


                     % DECLARATION AND SIGNATURES

\def\sigpages{
\setcounter{page}{2}  % page after title page is ii not i which is
                      % what LaTeX sets it to.
%--------------------------------------------------------------------
% Declaration page:
%---
\@clearChapterPage

  I hereby declare that I am the sole author of this thesis.

  I authorize the University of Waterloo to lend
  this thesis to other institutions or individuals
  for the purpose of scholarly research.

\vfill % \vskip 1in
  Weining Liu
\vfill % \vskip 1in

  I further authorize the University of Waterloo
  to reproduce this thesis by photocopying or by
  other means, in total or in part, at the request
  of other institutions or individuals for the
  purpose of scholarly research.

\vfill % \vskip 1in
  Weining Liu
\vfill % \vskip 1in

%--------------------------------------------------------------------
% Signatures page
%---
%\@clearChapterPage
%  The University of Waterloo requires the signatures of
%  all persons using or photocopying this thesis. Please
%  sign below, and give address and date.
%\clearpage
}% \sigpages


                              % ABSTRACT

\newPrepageEnvironment{abstract}{Abstract}


                          % ACKNOWLEDGEMENTS

\newPrepageEnvironment{acknowledgements}{Acknowledgements}


                             % TRADEMARKS

\newPrepageEnvironment{trademarks}{Trademarks}


                            % BIBLIOGRAPHY

  % Redefine bibliography from report.doc to add a table of
  % contents entry
\def\thebibliography#1{\chapter*{Bibliography\@mkboth
  {BIBLIOGRAPHY}{BIBLIOGRAPHY}}\addcontentsline{toc}{chapter}{Bibliography}\list
  {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \usecounter{enumi}}
    \def\newblock{\hskip .11em plus .33em minus .07em}
    \sloppy\clubpenalty4000\widowpenalty4000
    \sfcode`\.=1000\relax}

\let\endthebibliography=\endlist
