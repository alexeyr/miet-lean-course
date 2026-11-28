import «лекция1_вычисления_утверждения_и_доказательства»
import VersoSlides

open VersoSlides

def main : IO UInt32 :=
  slidesMain
    (config := { theme := "white", slideNumber := true, transition := "none",
                 width := 1600, height := 900,
                 extraCss := #[{
                   filename := "lecture.css"
                   contents := ⟨"
                     .reveal { font-size: 32px; }
                     .reveal .slides section { text-align: left; }
                     .reveal .slides h1, .reveal .slides h2 {
                       font-size: 1.48em; text-transform: none; color: #174b53;
                     }
                     .reveal pre { font-size: .88em; }
                     .reveal .lean-input code { color: #006d77; font-weight: bold; }
                     .reveal .lean-keyword code { color: var(--verso-code-keyword-color, #8839a0); }
                     .reveal p { margin: .42em 0; }
                   "⟩ }] })
    (doc := %doc «лекция1_вычисления_утверждения_и_доказательства»)
