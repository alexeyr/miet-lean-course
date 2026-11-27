import Mathlib.Basic.Real.Basic
import Mathlib.Tactic.Ring

/-! # Лекция 1. Вычисления, утверждения и доказательства

Чтобы подготовить примеры, выполните в папке курса:
`lake exe cache get Mathlib.Basic.Real.Basic Mathlib.Tactic.Ring`.
Откройте этот файл и поставьте курсор на команду или шаг доказательства.
-/

namespace Lecture1

-- Слайд 1. Установка Lean в VS Code или VSCodium
-- Откройте папку курса в редакторе, затем этот файл.

-- Слайд 2. Первые команды в Lean Playground
#eval 2 + 3 * 4
#eval (2 + 3) * 4
#check (2 + 3) * 4

-- Слайд 3. Выражения, типы и универсумы
#check Nat     -- Nat : Type
#check Type    -- Type : Type 1

-- Слайд 4. Вычитание и типы операндов
#check (2 : Int) - 7
#eval (2 : Int) - 7

#check 2 - 7
#eval 2 - 7

#eval (2 : Nat) - (7 : Int)

-- Слайд 5. Приведение типов
#check (2 : Nat) - (7 : Int)  -- ↑2 - 7 : ℤ

-- Слайд 6. Определение функции
def addOne (n : Nat) : Nat :=
  n + 1

#eval addOne 4

-- Слайд 7. Применение и скобки
def square (n : Nat) : Nat := n * n

#eval square 3 + 1
#eval square (3 + 1)
#eval square (square 3)

-- Слайд 8. Функция как аргумент
def twiceNat (f : Nat → Nat) (x : Nat) : Nat :=
  f (f x)

#check twiceNat addOne
#eval twiceNat addOne 3

-- Слайд 9. Функция без имени
#eval twiceNat (fun n => n * 2) 3
#eval twiceNat (fun n => n + n + 1) 3

-- Слайд 10. Какой тип нужен для двукратного применения?
def twice {α : Type} (f : α → α) (x : α) : α :=
  f (f x)

#eval twice addOne 10
#eval twice (fun b => !b) true
#eval twice (α := Nat) addOne 10

-- Слайд 11. Что именно проверяет Lean?
#eval twice addOne 3 = 5
#check twice addOne 3 = 5
example : twice addOne 3 = 5 := by
  rfl

theorem twice_addOne_3 : twice addOne 3 = 5 := by rfl

example : twice addOne 3 = 5 := twice_addOne_3

-- Замените 5 на 6 в #check и в формулировке теоремы. Что примет Lean?

-- Слайд 12. Из чего состоит доказательство
example (n : Nat) : addOne n = n + 1 := by
  rfl

-- Слайд 13. Читаем цель в InfoView
-- Замените rfl на sorry и прочитайте предупреждение. Поставьте курсор
-- перед sorry, чтобы увидеть цель, затем верните rfl.
example (n : Nat) : addOne n = n + 1 := by
  rfl

-- Слайд 14. От вычисления к общему утверждению
example {α : Type} (f : α → α) (x : α) :
    twice f x = f (f x) := by
  rfl

-- Слайд 15. Разбираем неудачную попытку
#eval twice addOne 3
#eval addOne 3

-- Слайд 16. Когда утверждение верно, а шаг не проходит
example (a b : Nat) : a + b = b + a := by
  -- Попробуйте заменить следующую строку на rfl и прочитать сообщение Lean.
  exact Nat.add_comm a b

-- Слайд 17. Как переписать выражение с помощью rw?
example (a b : ℝ) :
    (a + b)^2 = a^2 + 2*a*b + b^2 := by
  rw [pow_two, add_mul, mul_add, mul_add, mul_comm b a,
      pow_two, pow_two, two_mul, add_mul,
      ← add_assoc, add_assoc (a * a)]

-- Слайд 18. Как не перечислять все равенства?
example (a b : ℝ) :
    (a + b)^2 = a^2 + 2*a*b + b^2 := by
  ring

-- Верна ли эта формула для A B : Matrix (Fin 2) (Fin 2) ℝ?
-- Строки и столбцы индексируются значениями типа Fin 2: 0 и 1.

-- Слайд 19. Самостоятельно: два способа прибавить четыре
def addTwo (n : Nat) : Nat := n + 2
#eval twice addTwo 5

-- Слайд 20. Проверяем решения
example (n : Nat) :
    twice addTwo n = (n + 2) + 2 := by
  rfl

example (x : ℝ) : (x + 2) + 2 = x + 4 := by
  ring

end Lecture1
