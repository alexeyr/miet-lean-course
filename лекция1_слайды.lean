import «лекция1_вычисления_утверждения_и_доказательства»
import CourseSlides

open VersoSlides

def main : IO UInt32 :=
  slidesMain (config := CourseSlides.config "лекция1_слайды")
    (doc := %doc «лекция1_вычисления_утверждения_и_доказательства»)
