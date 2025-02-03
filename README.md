# M1_ic_projet_puissance4_xml  

Mathis Ruffieux - 2021  
  
Projet de puissance 4 en XML, SVG, XSD et XSLT.  
  
le projet utilise des technologies XML pour structurer les données, SVG pour la création de graphiques, XSD pour la définition et la validation de la structure des fichiers XML, et XSLT pour transformer les données XML en HTML pour la visualisation.  

### Pour générer html :  
- xsltproc transform.xslt valides/valide.xml > generator/1.html  

### Commande pour valider un document xml :  
- xml$ xmllint - -schema schema.xsd valides/valide2.xml - -noout
