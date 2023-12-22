# L'atelier du 18 décembre quand le prof est trop malade

## Objectif global

Déployer une DB (RDS ou DocumentDB selon les besoins), dans un sous réseau privé, dans un Security Group autorisant le trafic entrant
depuis 2 autres Security Groups : celui dans lequel seront nos instances où l'appli tourne, celui du bastion.


## En détail

- VPC
- subnet priv
- subnet pub
- IG
- NAT GW
- les tables de routage qui vont avec (`network.tf`)
- SG bastion
- SG web app
- SG RDS
- subnet group (on y met juste le subnet priv)
- RDS instance


Pour vérifier que tout marche :
- le déploiement est effectué sans erreur
- je peux me connecter en ssh au bastion avec la bonne clé SSH
- je peux effectuer des commandes sur la db depuis le bastion (selon l'engine)

Attention ici on prépare le SG de l'app, mais il n'est pas demandé de déployer des instances ec2 (auto scaling ou target group) ni de déployer l'app en question. Cependant si vous le faite c'est bonus.

En cas de difficulté: -> google.fr, ou Bard (ou Chat GPT mais il a des infos qui datent un peu)... Non vous pouvez aussi me demander allez.


## Rappel

L'évaluation de vendredi sera la continuité de cet atelier, il peut donc être d'une grande aide pour vos ateliers.

Modalités de l'évaluation:
- par groupes de 2 ou 3 (ou de 1), ou bien par groupes projet (donc plus de 3 si c'est le cas)

Objectifs:
- déployer le réseau (VPC + subnets + gateways) nécessaire
- déployer l'app (back et front) dans un auto scaling group derrière un load balancer
- déployer une DB managée (RDS ou Document, ou autre selon le besoin) dans un sous réseau privé
- mettre en place les Security Groups qui permettent tout le trafic
