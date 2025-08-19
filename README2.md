# TGVMAXiSchlag
fatigué de chasser les retours en TGV ? Chercher à la main prend des heures. Cet outil sert à vous donner des idées d'où aller en TGV MAX.

# Fonctionnement

Cet outil se base sur l'API de la SNCF ouverte au public. Cette API n'étant pas actualisée en temps réel, il est possible que **l'outil affiche des trains qui n'existent pas**. Si tel est le cas, gardez votre calme, et changez votre jour de recherche, quelle idée aussi d'espérer avoir un Paris-Bordeaux un jeudi de pont ?!?

# Prérequis
Vous devez avoir les éléments suivants installés sur votre machine : 

- Python 3 
- Les libraires Python argparse, requests, pyfiglet

# Usage

Integrated script
    ./return.sh 2025-08-28
If you have already searched, just display the cache
    python plot.py output/Paris-2025-08-28.txt.simple.csv
The detailed options are availbe in the output files

# Ajouts futurs

Idéalement, il faudra rendre de manière globale l'outil plus simple et agréable à utiliser. 
Les ajouts suivants sont prévus :
- Prise en compte des trains de nuit
- Prise en compte des trains à Luxembourg et à Fribourg, les deux trajets internationaux pour les jeunes
- Ajouter certaines gares que j'ai supprimé
- optimiser la recherche pour éviter le temps actu de 4 minutes
- changer la gare de destinaison
- confirmer que les coordonées sont vraies
