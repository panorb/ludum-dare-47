# Ludum Dare 47

Unser Projekt fürs [Ludum Dare 47](https://ldjam.com/).

# Konventionen

## Ordner- und Projektstruktur

Das Projekt wird nach den einzelnen modularen Features und Themen in Ordner sortiert.

Weiterhin werden die **Ordnernamen** und **Szenendateiennamen** im `UpperCamelCase` und in Einzahl, währenddessen die zugehörigen **Scriptdateinamen** und **Assets** im `snake_case` gehalten werden.

**Graphiken, Sounds und anderweitige Assets** werden zum Code direkt in die **passenden** Unterordner gepackt, neue Unterordner sind im Normalfall nicht notwendig, außer es handelt sich um eine extreme Menge an neuen Assets, die irgendwie sortiert oder gebändigt werden müssten.  
*Faustregel: Alles unter 3 Asset-Dateien braucht keine Extra-Unterordner.*

Wenn es Assets oder Code gibt, der an mehreren Stellen Verwendung findet (wie z.B. ein Feuersoundeffekt, den man für Drachenatem aber auch für ein Waldbrennen verwenden kann) so kommt dieser in den Shared-Ordner.  
*Ach hier gilt die 3 Asset-Faustregel.*

### Beispiel

Wenn das Projekt beispielsweise eine Reihe an Monstern hat (einen Zombie, einen Drachen und einen pinken und einen roten Elefanten) haben wir ein Verzeichnis "Monster" und dann jeweils Unterordner für die einzelnen Monster.
Die Projektstruktur könnte dann also beispielsweise so aussehen:

```
godot
├───Monster
│   │   monster.gd
│   ├───Dragon
│   │   │   dragon.gd
│   │   │   dragon.png
│   │   │   Dragon.tscn
│   │   ├───Sounds
│   │   │       dragon_angry.ogg
│   │   │       dragon_howl.ogg
│   │   │       dragon_wing_flap.ogg
│   │   └───States
│   │           fire_breath.gd
│   │           hovering.gd
│   │           howl.gd
│   │           idle.gd
│   ├───Elephant
│   │   │   elephant_colorless.png
│   │   │   elephant.gd
│   │   │   Elephant.tscn
│   │   │   elephant_horn.ogg
│   │   ├───PinkElephant
│   │   │       PinkElephant.tscn
│   │   │       pink_elephant.gd
│   │   └───RedElephant
│   │           RedElephant.tscn
│   │           red_elephant.gd
│   └───Zombie
│           zombie.gd
│           Zombie.tscn
│           zombie_death.png
│           zombie_drooling.png
│           zombie_growl.ogg
└───Shared
        fire_burn.ogg
```

## Branching
Für neue Branches folgen folgenden Konventionen eingehalten: 
- Wenn ein neues Feature entwickelt wird erstellen wir einen neuen Branch der mit `dev-` und dann dem englischen Featurenamen in `kebab-case`
- **Beispiele:** `dev-main-menu` oder `dev-dragon-monster`.

## Leo
Die Ordnerstruktur im root-Ordner ist fucked. Sortier mal.

## Codekonventionen

Ansonsten folgen wir den [GDScript Richtlinien, die in der Godot-Dokumentation beschrieben sind](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/gdscript_styleguide.html)

Und zusätzlich den [Best Practices von GDQuest](https://www.gdquest.com/docs/guidelines/best-practices/godot-gdscript/)

Bitte nehmt euch bevor ihr mit eurer Arbeit startet einen Moment Zeit und schaut euch diese an.
