\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tech-report}[2019/07/28 tech-report class]
\RequirePackage[utf8]{inputenc}

\PassOptionsToPackage{paper=letter}{typearea}
\LoadClass{scrreprt}

% Fonts & colours
\RequirePackage[T1]{fontenc}
\RequirePackage[tt=false, type1, oldstyle]{libertine}
\RequirePackage[libertine]{newtxmath}
\RequirePackage[varqu]{inconsolata}
\RequirePackage{microtype}
\RequirePackage[usenames, dvipsnames]{xcolor}
\definecolor{BerkeleyBlue}{rgb}{0, 0.125, 0.25}

% Hyperlinks
\RequirePackage[hyphens]{url}
\RequirePackage[%
  colorlinks = true,
  citecolor  = BerkeleyBlue,
  linkcolor  = BerkeleyBlue,
  urlcolor   = BerkeleyBlue,
]{hyperref}
\RequirePackage{bookmark}
  
% Paragraph lists & compact enumerations
\RequirePackage[inline]{enumitem}

% Spacing
\RequirePackage{setspace}
\onehalfspacing

% Tables
\RequirePackage{booktabs}
\RequirePackage{multirow}

% Penalties
\clubpenalty         = 10000
\widowpenalty        = 10000
\displaywidowpenalty = 10000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some adjustments to make the bibliography more clean
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The subsequent commands do the following:
%  - Removing the month field from the bibliography
%  - Fixing the Oxford comma
%  - Remove the parentheses of the year in an article
%  - Delimit volume and issue of an article by a colon ":" instead of
%    a dot ""
%  - Use commas to separate the location of publishers from their name
%  - Remove the abbreviation for technical reports
%  - Display the label of bibliographic entries without brackets in the
%    bibliography
%  - Ensure that DOIs are followed by a non-breakable space
%  - Use hair spaces between initials of authors
%  - Make the font size of citations smaller
\RequirePackage[%
  autocite     = plain,
  backend      = biber,
  doi          = true,
  url          = true,
  giveninits   = true,
  hyperref     = true,
  maxbibnames  = 99,
  maxcitenames = 99,
  sortcites    = true,
  style        = numeric,
]{biblatex}

% Remove the month field from the bibliography
\AtEveryBibitem{\clearfield{month}}
\AtEveryCitekey{\clearfield{month}}

% Fixing the Oxford comma
\AtBeginBibliography{%
  \renewcommand*{\finalnamedelim}{%
    \ifthenelse{\value{listcount} > 2}{%
      \addcomma
      \addspace
      \bibstring{and}%
    }{%
      \addspace
      \bibstring{and}%
    }
  }
}

% Remove the parentheses for the year in an article
\renewbibmacro*{issue+date}{%
  \setunit{\addcomma\space}
    \iffieldundef{issue}
      {\usebibmacro{date}}
      {\printfield{issue}%
       \setunit*{\addspace}%
       \usebibmacro{date}}%
  \newunit}

% Delimit the volume and the number of an article by a colon instead of by a dot
\renewbibmacro*{volume+number+eid}{%
  \printfield{volume}%
  \setunit*{\addcolon}%
  \printfield{number}%
  \setunit{\addcomma\space}%
  \printfield{eid}%
}

% Connect publisher, location, and date via commas
\renewbibmacro*{publisher+location+date}{%
  \printlist{publisher}%
  \setunit*{\addcomma\space}%
  \printlist{location}%
  \setunit*{\addcomma\space}%
  \usebibmacro{date}%
  \newunit%
}
\renewbibmacro*{organization+location+date}{%
  \printlist{location}%
  \setunit*{\addcomma\space}%
  \printlist{organization}%
  \setunit*{\addcomma\space}%
  \usebibmacro{date}%
  \newunit%
}

% Do not abbreviate "technical report".
\DefineBibliographyStrings{english}{%
  bibliography = {Bibliography},
  techreport   = {Technical report},
}

% Display the label of a bibliographic entry in bare style, without any brackets
\DeclareFieldFormat{labelnumberwidth}{#1\adddot}

% Ensure that DOIs are followed by a non-breakable space
\DeclareFieldFormat{doi}{%
  \mkbibacro{DOI}\addcolon\addnbspace
    \ifhyperref
      {\href{http://dx.doi.org/#1}{\nolinkurl{#1}}}
      %
      {\nolinkurl{#1}}
}

% Use proper hair spaces between initials
\renewcommand*\bibinitdelim {\addnbthinspace}
\renewcommand*\bibnamedelima{\addnbthinspace}
\renewcommand*\bibnamedelimb{\addnbthinspace}
\renewcommand*\bibnamedelimi{\addnbthinspace}
