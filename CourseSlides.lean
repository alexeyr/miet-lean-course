import VersoSlides

namespace CourseSlides

@[role]
meta def leanResult : Verso.Doc.Elab.RoleExpanderOf Unit
  | _, contents => VersoSlides.classRole ⟨#["lean-result"]⟩ contents

@[role]
meta def leanInput : Verso.Doc.Elab.RoleExpanderOf Unit
  | _, contents => VersoSlides.classRole ⟨#["lean-input"]⟩ contents

@[directive]
meta def answerStep : Verso.Doc.Elab.DirectiveExpanderOf Unit
  | _, contents => VersoSlides.«class» ⟨#["answer-step"]⟩ contents

def config (dir : System.FilePath) : VersoSlides.Config :=
  { theme := "dracula", slideNumber := true, transition := "none",
    outputDir := dir, width := 1600, height := 900,
    -- Reuse the elaborated query results when an operator has a unique
    -- documentation target on the current slide.
    extraHead := #[.element "script" #[] (.raw "
      document.addEventListener('DOMContentLoaded', () => {
        for (const slide of document.querySelectorAll('.reveal .slides section:not(:has(section))')) {
          const targets = new Map();
          for (const token of slide.querySelectorAll('.command-output .const[data-verso-hover]')) {
            const symbol = token.textContent;
            const id = token.dataset.versoHover;
            targets.set(symbol, targets.has(symbol) && targets.get(symbol) !== id ? null : id);
          }
          for (const op of slide.querySelectorAll('.operator:not([data-verso-hover])')) {
            const id = targets.get(op.textContent);
            if (id) op.dataset.versoHover = id;
          }
        }
      });
    ")],
    extraCss := #[{
      filename := "lecture.css"
      contents := ⟨"
        .reveal {
          font-size: 32px; font-family: Verdana, Arial, sans-serif;
          --verso-code-keyword-color: #ff79c6;
          --verso-code-const-color: #8be9fd;
          --verso-code-var-color: #50fa7b;
          --verso-code-comment-color: #a5accb;
        }
        .reveal .slides code.hl.lean.inline { background-color: var(--r-background-color); }
        .reveal .slides section { text-align: left; }
        .reveal .slides h1, .reveal .slides h2 {
          font-family: inherit; font-size: 1.48em; font-weight: normal;
          text-transform: none; color: var(--r-heading-color);
        }
        .reveal .lean-result code { color: var(--verso-code-var-color); font-family: monospace; }
        .reveal section:has(.lean-result) .command-output { display: none; }
        .reveal .slides pre:not(.code-with-panel pre),
        .reveal .slides code.hl.lean.block,
        .reveal .slides .info-panel { font-size: 32px; }
        .reveal .slides .code-with-panel .token[data-verso-hover]:hover {
          background-color: #44475a;
        }
        .reveal .lean-input code { color: var(--verso-code-var-color); font-weight: bold; }
        .reveal p { margin: .32em 0; }
        .reveal .slides p.fragment { transition: none; will-change: auto; }
      "⟩ }] }

end CourseSlides
