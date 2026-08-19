\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{genesisl1-paper}[2026/08/01 v3.0 GenesisL1 community scientific paper]

% -----------------------------------------------------------------------------
% Class options
% -----------------------------------------------------------------------------
\newif\ifGenesisTwoColumn
\newif\ifGenesisChemistry
\newif\ifGenesisBiochemistry
\newif\ifGenesisBiology
\newif\ifGenesisBlockchain
\newif\ifGenesisComputerScience

\GenesisTwoColumntrue
\GenesisChemistryfalse
\GenesisBiochemistryfalse
\GenesisBiologyfalse
\GenesisBlockchainfalse
\GenesisComputerSciencefalse

\DeclareOption{twocolumn}{\GenesisTwoColumntrue}
\DeclareOption{onecolumn}{\GenesisTwoColumnfalse}
\DeclareOption{chemistry}{\GenesisChemistrytrue}
\DeclareOption{biochemistry}{\GenesisBiochemistrytrue\GenesisChemistrytrue}
\DeclareOption{biology}{\GenesisBiologytrue}
\DeclareOption{blockchain}{\GenesisBlockchaintrue}
\DeclareOption{computerscience}{\GenesisComputerSciencetrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\ifGenesisTwoColumn
  \LoadClass[10pt,a4paper,twocolumn]{article}
\else
  \LoadClass[11pt,a4paper]{article}
\fi

% -----------------------------------------------------------------------------
% Core packages
% -----------------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{newtxtext}
\RequirePackage{newtxmath}
\RequirePackage{noto-sans}
\RequirePackage[
  a4paper,
  top=18mm,
  bottom=20mm,
  left=18mm,
  right=18mm,
  headheight=22pt,
  headsep=6mm,
  footskip=10mm
]{geometry}
\RequirePackage{microtype}
\RequirePackage{xcolor}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{enumitem}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{amsmath}
\RequirePackage{siunitx}
\RequirePackage{mathtools}
\RequirePackage{listings}
\RequirePackage[most]{tcolorbox}
\RequirePackage{xparse}
\RequirePackage{etoolbox}
\RequirePackage[numbers,sort&compress]{natbib}
\RequirePackage{hyperref}
\RequirePackage[nameinlink,noabbrev]{cleveref}
\RequirePackage{dblfloatfix}
\RequirePackage{placeins}
\RequirePackage{needspace}
\RequirePackage{newfloat}

\setlength{\columnsep}{7mm}
\setlength{\columnseprule}{0pt}
\setlength{\parindent}{1em}
\setlength{\parskip}{0pt}
\setlength{\emergencystretch}{2em}
\linespread{1.02}

% -----------------------------------------------------------------------------
% Official July 2026 palette
% -----------------------------------------------------------------------------
\definecolor{GenesisBlack}{HTML}{000000}
\definecolor{GenesisNavy}{HTML}{1A2E4A}
\definecolor{GenesisBlue}{HTML}{315A85}
\definecolor{GenesisInk}{HTML}{20252B}
\definecolor{GenesisMist}{HTML}{EFF4F8}
\definecolor{GenesisRules}{HTML}{CBD2D9}
\definecolor{GenesisWhite}{HTML}{FFFFFF}
\definecolor{GenesisAmber}{HTML}{8B6418}
\definecolor{GenesisAmberPale}{HTML}{FBF6EA}
\definecolor{GenesisGreen}{HTML}{2F6B55}
\definecolor{GenesisGreenPale}{HTML}{EEF6F2}
\definecolor{GenesisCodeBg}{HTML}{F5F7F9}
\definecolor{GenesisCodeRule}{HTML}{D9E0E6}

\color{GenesisInk}

\hypersetup{
  colorlinks=true,
  linkcolor=GenesisBlue,
  urlcolor=GenesisBlue,
  citecolor=GenesisBlue,
  pdfborder={0 0 0}
}
\urlstyle{same}

% -----------------------------------------------------------------------------
% Metadata
% -----------------------------------------------------------------------------
\newcommand{\GLTitle}{Untitled scientific paper}
\newcommand{\GLSubtitle}{}
\newcommand{\GLRunningTitle}{Untitled paper}
\newcommand{\GLVersion}{Draft 0.1}
\newcommand{\GLStatus}{DRAFT}
\newcommand{\GLDate}{\today}
\newcommand{\GLAuthors}{Author names}
\newcommand{\GLAffiliations}{Affiliations}
\newcommand{\GLCorrespondence}{}
\newcommand{\GLIdentifier}{}
\newcommand{\GLRepository}{}
\newcommand{\GLFields}{}
\newcommand{\GLKeywords}{}
\newcommand{\GLLicense}{CC BY 4.0}
\newcommand{\GLLogoFile}{assets/brand/genesisl1-lockup-navy-2400.png}

\NewDocumentCommand{\GenesisTitle}{m}{\renewcommand{\GLTitle}{#1}}
\NewDocumentCommand{\GenesisSubtitle}{m}{\renewcommand{\GLSubtitle}{#1}}
\NewDocumentCommand{\GenesisRunningTitle}{m}{\renewcommand{\GLRunningTitle}{#1}}
\NewDocumentCommand{\GenesisVersion}{m}{\renewcommand{\GLVersion}{#1}}
\NewDocumentCommand{\GenesisStatus}{m}{\renewcommand{\GLStatus}{#1}}
\NewDocumentCommand{\GenesisDate}{m}{\renewcommand{\GLDate}{#1}}
\NewDocumentCommand{\GenesisAuthors}{m}{\renewcommand{\GLAuthors}{#1}}
\NewDocumentCommand{\GenesisAffiliations}{m}{\renewcommand{\GLAffiliations}{#1}}
\NewDocumentCommand{\GenesisCorrespondence}{m}{\renewcommand{\GLCorrespondence}{#1}}
\NewDocumentCommand{\GenesisIdentifier}{m}{\renewcommand{\GLIdentifier}{#1}}
\NewDocumentCommand{\GenesisRepository}{m}{\renewcommand{\GLRepository}{#1}}
\NewDocumentCommand{\GenesisFields}{m}{\renewcommand{\GLFields}{#1}}
\NewDocumentCommand{\GenesisKeywords}{m}{\renewcommand{\GLKeywords}{#1}}
\NewDocumentCommand{\GenesisLicense}{m}{\renewcommand{\GLLicense}{#1}}
\NewDocumentCommand{\GenesisLogoFile}{m}{\renewcommand{\GLLogoFile}{#1}}

\NewDocumentCommand{\GenesisLogo}{O{8mm}}{%
  \IfFileExists{\GLLogoFile}{%
    \includegraphics[height=#1,keepaspectratio]{\GLLogoFile}%
  }{%
    {\sffamily\bfseries\color{GenesisNavy}GenesisL1}%
  }%
}

% -----------------------------------------------------------------------------
% Page furniture: logo only on the first page
% -----------------------------------------------------------------------------
\fancypagestyle{genesisfirst}{
  \fancyhf{}
  \fancyfoot[C]{\sffamily\small\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
}

\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\sffamily\scriptsize\color{GenesisNavy}\GLRunningTitle}
\fancyhead[R]{\sffamily\scriptsize\color{GenesisInk}Scientific Paper \textperiodcentered\ \GLVersion}
\fancyfoot[C]{\sffamily\scriptsize\color{GenesisInk}\thepage\ /\ \pageref*{LastPage}}
\renewcommand{\headrulewidth}{0.35pt}
\renewcommand{\headrule}{%
  \hbox to\headwidth{\color{GenesisRules}\leaders\hrule height \headrulewidth\hfill}%
}
\renewcommand{\footrulewidth}{0pt}

% -----------------------------------------------------------------------------
% Section hierarchy
% -----------------------------------------------------------------------------
\titleformat{\section}
  {\sffamily\bfseries\large\color{GenesisInk}}
  {\thesection}{0.55em}{}
  [\vspace{0.08em}{\color{GenesisRules}\titlerule}]
\titlespacing*{\section}{0pt}{1.15em}{0.45em}

\titleformat{\subsection}
  {\sffamily\bfseries\normalsize\color{GenesisInk}}
  {\textcolor{GenesisBlue}{\thesubsection}}{0.45em}{}
\titlespacing*{\subsection}{0pt}{0.9em}{0.28em}

\titleformat{\subsubsection}
  {\sffamily\bfseries\normalsize\color{GenesisInk}}
  {\textcolor{GenesisBlue}{\thesubsubsection}}{0.4em}{}
\titlespacing*{\subsubsection}{0pt}{0.75em}{0.22em}

% Avoid leaving a section heading alone at the foot of a column.
\pretocmd{\section}{\Needspace{4\baselineskip}}{}{}
\pretocmd{\subsection}{\Needspace{3\baselineskip}}{}{}

% -----------------------------------------------------------------------------
% Front matter
% -----------------------------------------------------------------------------
\newcommand{\GenesisLabel}[1]{%
  {\sffamily\bfseries\scriptsize\color{GenesisBlue}\MakeUppercase{#1}}%
}

\newcommand{\GenesisStatusBadge}[1]{%
  \begingroup
  \setlength{\fboxsep}{3pt}%
  \colorbox{GenesisMist}{%
    {\sffamily\bfseries\tiny\color{GenesisBlue}\MakeUppercase{#1}}%
  }%
  \endgroup
}

\newcommand{\GenesisTitleContent}{%
  \thispagestyle{genesisfirst}
  \noindent
  \begin{minipage}[t]{0.62\textwidth}
    \GenesisLogo[8.5mm]
  \end{minipage}
  \begin{minipage}[t]{0.37\textwidth}
    \raggedleft
    \GenesisLabel{Scientific paper}\\[1mm]
    {\sffamily\small\GLVersion\space\textperiodcentered\space\GLDate}
  \end{minipage}
  \par\vspace{7mm}
  {\raggedright\sffamily\bfseries\fontsize{23}{27}\selectfont\color{GenesisNavy}\GLTitle\par}
  \ifdefempty{\GLSubtitle}{}{%
    \vspace{2mm}
    {\raggedright\itshape\large\color{GenesisBlue}\GLSubtitle\par}
  }
  \vspace{4mm}
  {\small\GLAuthors\par}
  {\small\GLAffiliations\par}
  \ifdefempty{\GLCorrespondence}{}{%
    \vspace{1mm}{\small\textbf{Correspondence:} \GLCorrespondence\par}
  }
  \vspace{3mm}
  \GenesisStatusBadge{\GLStatus}
  \ifdefempty{\GLFields}{}{\hspace{1mm}\GenesisStatusBadge{\GLFields}}
  \ifdefempty{\GLIdentifier}{}{%
    \hspace{1mm}{\sffamily\tiny\color{GenesisInk}\GLIdentifier}
  }
  \vspace{4mm}
  {\color{GenesisRules}\rule{\textwidth}{0.6pt}}\par
}

\NewDocumentEnvironment{GenesisFrontMatter}{+b}{%
  \ifGenesisTwoColumn
    \twocolumn[%
      \begin{@twocolumnfalse}
        \GenesisTitleContent
        #1
        \vspace{5mm}
      \end{@twocolumnfalse}
    ]%
  \else
    \GenesisTitleContent
    #1
    \vspace{5mm}
  \fi
}{}

\NewDocumentEnvironment{GenesisStructuredAbstract}{+b}{%
  \begin{tcolorbox}[
    enhanced,
    breakable,
    colback=GenesisWhite,
    colframe=GenesisWhite,
    boxrule=0pt,
    arc=0pt,
    left=5mm,right=1mm,top=1mm,bottom=1mm,
    borderline west={1.2pt}{0pt}{GenesisBlue},
    before skip=4pt,after skip=3pt
  ]
  {\sffamily\bfseries\color{GenesisNavy}Abstract}\par\smallskip
  \small #1
  \ifdefempty{\GLKeywords}{}{%
    \par\smallskip
    \noindent{\sffamily\bfseries\small\color{GenesisNavy}Keywords:}
    {\small\ \GLKeywords}
  }
  \end{tcolorbox}
}{}

\NewDocumentCommand{\AbstractBackground}{m}{%
  \par\noindent{\sffamily\bfseries Background / Purpose.}\ #1%
}
\NewDocumentCommand{\AbstractMethods}{m}{%
  \par\noindent{\sffamily\bfseries Methods.}\ #1%
}
\NewDocumentCommand{\AbstractResults}{m}{%
  \par\noindent{\sffamily\bfseries Results.}\ #1%
}
\NewDocumentCommand{\AbstractConclusion}{m}{%
  \par\noindent{\sffamily\bfseries Conclusion.}\ #1%
}

\NewDocumentEnvironment{GenesisAbstract}{+b}{%
  \begin{tcolorbox}[
    enhanced,breakable,colback=GenesisWhite,colframe=GenesisWhite,
    boxrule=0pt,arc=0pt,left=5mm,right=1mm,top=1mm,bottom=1mm,
    borderline west={1.2pt}{0pt}{GenesisBlue}
  ]
  {\sffamily\bfseries\color{GenesisNavy}Abstract}\par\smallskip
  \small #1
  \ifdefempty{\GLKeywords}{}{%
    \par\smallskip
    \noindent{\sffamily\bfseries\small\color{GenesisNavy}Keywords:}
    {\small\ \GLKeywords}
  }
  \end{tcolorbox}
}{}

% -----------------------------------------------------------------------------
% Scientific reasoning modules
% -----------------------------------------------------------------------------
\NewDocumentEnvironment{GenesisEvidence}{O{Evidence / observation}+b}{%
  \begin{tcolorbox}[
    enhanced,breakable,colback=GenesisMist,colframe=GenesisRules,
    boxrule=0.5pt,arc=0pt,left=4mm,right=4mm,top=2.5mm,bottom=2.5mm
  ]
  \GenesisLabel{#1}\par\smallskip
  #2
  \end{tcolorbox}
}{}

\NewDocumentEnvironment{GenesisInterpretation}{+b}{%
  \begin{tcolorbox}[
    enhanced,breakable,colback=GenesisWhite,colframe=GenesisRules,
    boxrule=0.5pt,arc=0pt,left=4mm,right=4mm,top=2.5mm,bottom=2.5mm,
    borderline west={1.4pt}{0pt}{GenesisBlue}
  ]
  {\sffamily\bfseries\color{GenesisNavy}Interpretation}\par\smallskip
  #1
  \end{tcolorbox}
}{}

\NewDocumentEnvironment{GenesisLimitations}{+b}{%
  \begin{tcolorbox}[
    enhanced,breakable,colback=GenesisAmberPale,colframe=GenesisRules,
    boxrule=0.5pt,arc=0pt,left=4mm,right=4mm,top=2.5mm,bottom=2.5mm
  ]
  {\sffamily\bfseries\color{GenesisAmber}Limitations and uncertainty}\par\smallskip
  #1
  \end{tcolorbox}
}{}

\NewDocumentEnvironment{GenesisTrustBoundary}{+b}{%
  \begin{tcolorbox}[
    enhanced,breakable,colback=GenesisWhite,colframe=GenesisWhite,
    boxrule=0pt,arc=0pt,left=5mm,right=1mm,top=1.5mm,bottom=1.5mm,
    borderline west={1.2pt}{0pt}{GenesisBlue}
  ]
  {\sffamily\bfseries\color{GenesisNavy}Scientific trust boundary}\par\smallskip
  #1
  \end{tcolorbox}
}{}

\NewDocumentEnvironment{GenesisProvenance}{+b}{%
  \begin{tcolorbox}[
    enhanced,breakable,colback=GenesisGreenPale,colframe=GenesisRules,
    boxrule=0.5pt,arc=0pt,left=4mm,right=4mm,top=2.5mm,bottom=2.5mm
  ]
  {\sffamily\bfseries\color{GenesisGreen}Provenance and reproducibility}\par\smallskip
  #1
  \end{tcolorbox}
}{}

% -----------------------------------------------------------------------------
% Exact artifact and future IPFS metadata
% -----------------------------------------------------------------------------
\newcommand{\GLDataIdentifier}{}
\newcommand{\GLCodeIdentifier}{}
\newcommand{\GLModelIdentifier}{}
\newcommand{\GLExecutionIdentifier}{}
\newcommand{\GLContentHash}{}
\newcommand{\GLIPFSCID}{}
\newcommand{\GLIPFSGateway}{}

\NewDocumentCommand{\GenesisDataIdentifier}{m}{\renewcommand{\GLDataIdentifier}{#1}}
\NewDocumentCommand{\GenesisCodeIdentifier}{m}{\renewcommand{\GLCodeIdentifier}{#1}}
\NewDocumentCommand{\GenesisModelIdentifier}{m}{\renewcommand{\GLModelIdentifier}{#1}}
\NewDocumentCommand{\GenesisExecutionIdentifier}{m}{\renewcommand{\GLExecutionIdentifier}{#1}}
\NewDocumentCommand{\GenesisContentHash}{m}{\renewcommand{\GLContentHash}{#1}}
\NewDocumentCommand{\GenesisIPFSCID}{m}{\renewcommand{\GLIPFSCID}{#1}}
\NewDocumentCommand{\GenesisIPFSGateway}{m}{\renewcommand{\GLIPFSGateway}{#1}}

\NewDocumentCommand{\PrintGenesisArtifactRecord}{}{%
  \begin{GenesisProvenance}
  \begin{tabularx}{\linewidth}{@{}>{\sffamily\bfseries}p{0.31\linewidth}X@{}}
    Data & \GLDataIdentifier\\
    Code & \GLCodeIdentifier\\
    Model & \GLModelIdentifier\\
    Execution & \GLExecutionIdentifier\\
    Content hash & \GLContentHash\\
    IPFS CID & \GLIPFSCID\\
    Gateway hint & \GLIPFSGateway\\
  \end{tabularx}
  \end{GenesisProvenance}
}

% -----------------------------------------------------------------------------
% Figures, tables, equations and references
% -----------------------------------------------------------------------------
\captionsetup{
  font=small,
  labelfont={bf,sf,color=GenesisBlue},
  textfont={color=GenesisInk},
  labelsep=period
}
\captionsetup[figure]{position=bottom}
\captionsetup[table]{position=top}

\crefname{figure}{figure}{figures}
\Crefname{figure}{Figure}{Figures}
\crefname{table}{table}{tables}
\Crefname{table}{Table}{Tables}
\crefname{equation}{equation}{equations}
\Crefname{equation}{Equation}{Equations}
\crefname{section}{section}{sections}
\Crefname{section}{Section}{Sections}
\crefname{lstlisting}{listing}{listings}
\Crefname{lstlisting}{Listing}{Listings}

\NewDocumentEnvironment{GenesisWideFigure}{O{t}+b}{%
  \begin{figure*}[#1]
  \centering
  #2
}{%
  \end{figure*}
}

\NewDocumentEnvironment{GenesisWideTable}{O{t}+b}{%
  \begin{table*}[#1]
  \centering
  #2
}{%
  \end{table*}
}

% -----------------------------------------------------------------------------
% Code listings: no shell escape required
% -----------------------------------------------------------------------------
\lstdefinelanguage{Solidity}{
  keywords={pragma,solidity,contract,interface,library,function,modifier,event,
    struct,enum,mapping,address,uint,uint256,int,bool,bytes,string,memory,
    storage,calldata,public,private,internal,external,view,pure,payable,
    returns,return,emit,require,revert,constructor,immutable,constant,
    indexed,override,virtual,new,delete,if,else,for,while},
  sensitive=true,
  morecomment=[l]{//},
  morecomment=[s]{/*}{*/},
  morestring=[b]"
}

\lstdefinelanguage{JSON}{
  string=[s]{"}{"},
  stringstyle=\color{GenesisGreen},
  comment=[l]{//},
  commentstyle=\color{GenesisBlue},
  keywords={true,false,null},
  keywordstyle=\color{GenesisBlue}\bfseries
}

\lstdefinestyle{GenesisCodeStyle}{
  basicstyle=\ttfamily\footnotesize,
  keywordstyle=\color{GenesisBlue}\bfseries,
  commentstyle=\color{GenesisGreen},
  stringstyle=\color{GenesisAmber},
  numbers=left,
  numberstyle=\tiny\color{GenesisBlue},
  numbersep=7pt,
  frame=single,
  rulecolor=\color{GenesisCodeRule},
  backgroundcolor=\color{GenesisCodeBg},
  framesep=5pt,
  framerule=0.5pt,
  breaklines=true,
  showstringspaces=false,
  tabsize=2,
  columns=fullflexible,
  keepspaces=true,
  captionpos=b,
  aboveskip=0.7em,
  belowskip=0.7em
}

\lstnewenvironment{GenesisCode}[1][]%
  {\lstset{style=GenesisCodeStyle,#1}}%
  {}

\NewDocumentCommand{\GenesisCodeFile}{O{} m}{%
  \lstinputlisting[style=GenesisCodeStyle,#1]{#2}%
}

% -----------------------------------------------------------------------------
% Field profiles
% -----------------------------------------------------------------------------
\NewDocumentCommand{\taxon}{m}{\textit{#1}}
\NewDocumentCommand{\gene}{m}{\textit{#1}}
\NewDocumentCommand{\protein}{m}{\textup{#1}}
\NewDocumentCommand{\software}{m}{\texttt{#1}}
\NewDocumentCommand{\hash}{m}{\texttt{\small #1}}
\NewDocumentCommand{\contract}{m}{\texttt{\small #1}}

\ifGenesisChemistry
  \RequirePackage[version=4]{mhchem}
  \RequirePackage{chemfig}
  \RequirePackage{chemnum}
  \RequirePackage{chemmacros}
  \DeclareFloatingEnvironment[fileext=los,name=Scheme,placement=tb]{scheme}
  \crefname{scheme}{scheme}{schemes}
  \Crefname{scheme}{Scheme}{Schemes}
  \NewDocumentCommand{\compound}{m}{\cmpd{#1}}
  \NewDocumentCommand{\compoundref}{m}{\refcmpd{#1}}
\else
  \NewDocumentCommand{\compound}{m}{\textbf{#1}}
  \NewDocumentCommand{\compoundref}{m}{\textbf{#1}}
\fi

% -----------------------------------------------------------------------------
% List defaults
% -----------------------------------------------------------------------------
\setlist[itemize]{
  label=\textcolor{GenesisBlue}{\(\blacktriangleright\)},
  leftmargin=1.55em,
  itemsep=0.18em,
  topsep=0.3em
}
\setlist[enumerate]{
  leftmargin=1.8em,
  itemsep=0.18em,
  topsep=0.3em
}

% -----------------------------------------------------------------------------
% End matter helper
% -----------------------------------------------------------------------------
\NewDocumentCommand{\GenesisEndMatterNotice}{}{%
  \par\smallskip
  {\footnotesize\color{GenesisInk}
  \textbf{Template principle.} A supportive container, not a Procrustean bed.
  Remove modules that do not serve the paper and add field-specific reporting
  requirements where appropriate.}
}

\AtBeginDocument{%
  \pdfstringdefDisableCommands{%
    \def\GenesisStatusBadge#1{#1}%
    \def\taxon#1{#1}%
    \def\gene#1{#1}%
    \def\protein#1{#1}%
    \def\compound#1{#1}%
  }%
}
