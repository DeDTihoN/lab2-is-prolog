% Факти is_a

% Перший рівень
is_a(building, structure).
is_a(bridge, structure).

% Другий рівень
is_a(house, building).
is_a(skyscraper, building).
is_a(arch_bridge, bridge).
is_a(suspension_bridge, bridge).

% Третій рівень
is_a(apartment, house).
is_a(villa, house).
is_a(office_tower, skyscraper).
is_a(warehouse, skyscraper).
is_a(stone_arch_bridge, arch_bridge).
is_a(steel_arch_bridge, arch_bridge).
is_a(golden_gate_bridge, suspension_bridge).
is_a(brooklyn_bridge, suspension_bridge).


% Факти part_of
part_of(roof, building).
part_of(wall, building).
part_of(window, building).
part_of(door, building).
part_of(pillar, bridge).
part_of(foundation, building).
part_of(seat, stadium).
part_of(bell, tower).
part_of(floor, building).
part_of(ladder, building).
part_of(altar, church).
part_of(arch, arch_bridge).
part_of(cable, suspension_bridge).
part_of(tower, suspension_bridge).
part_of(beam, warehouse).
part_of(ceiling, house).
part_of(garage, villa).
part_of(balcony, apartment).
part_of(bedroom, house).
part_of(elevator, office_tower).
part_of(desk, office_tower).
part_of(kitchen, villa).
part_of(door, apartment).
part_of(door, villa).
part_of(crossbeam, stone_arch_bridge).
part_of(anchor, brooklyn_bridge).
part_of(tower, golden_gate_bridge).

% Властивості (матеріали)
material(roof, tile).
material(window, glass).
material(door, wood).
material(foundation, concrete).
material(pillar, steel).
material(seat, plastic).
material(bell, metal).
material(altar, marble).
material(arch, stone).
material(cable, steel).
material(tower, iron).
material(beam, wood).
material(ceiling, drywall).
material(garage, brick).
material(balcony, concrete).
material(bedroom, wood).
material(elevator, steel).
material(desk, wood).
material(kitchen, granite).
material(door, steel).
material(crossbeam, iron).
material(anchor, steel).

% Правила виведення
is_a_rec(X, Z):- is_a(X, Z).
is_a_rec(X, Z) :- is_a(X, Y), is_a_rec(Y, Z).
part_of_rec(X, Z) :- part_of(X, Z).
part_of_rec(X, Z) :- part_of(X, Y), part_of_rec(Y, Z).

% Наслідування властивостей по зв'язку is_a
height(X, H) :- is_a_rec(X, Y), height(Y, H).

% Наприклад, башта tower може бути спорудою з дзвоном та іншими частинами
material(X, M) :- part_of_rec(Y,X), material(Y, M).

% Базовий факт для хмарочоса newscraper з висотою 100 метрів
newscraper_nth(1, newscraper, 100).

% Рекурсивне правило для генерації нових хмарочосів із висотою n метрів
newscraper_nth(N, newscraper, Height) :-
    N > 1,                     % Перевіряємо, що N більше за 1
    PrevN is N - 1,             % Обчислюємо попередній номер хмарочоса
    newscraper_nth(PrevN, newscraper, PrevHeight), % Рекурсивний виклик для попереднього хмарочоса
    Height is PrevHeight + 50.  % Збільшуємо висоту на 50 метрів

% Генерація і виведення хмарочоса
newscraper_generate(N) :-
    newscraper_nth(N, newscraper, Height),  % Генеруємо висоту для хмарочоса
    format('Generated newscraper ~d with height ~d meters.~n', [N, Height]).

% main для тестування генерації хмарочосів з висотою n метрів
main :-
    % Перевіримо перший хмарочос
    newscraper_generate(1),

    % Перевіримо другий хмарочос
    newscraper_generate(2),

    % Генеруємо третій хмарочос
    newscraper_generate(3),

    between(1, inf, N), newscraper_generate(N).

