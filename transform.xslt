<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 

  <xsl:output method="xml" indent="yes"/>

  <!-- Pour générer html :
  xsltproc transform.xslt valides/valide.xml > generator/1.html
   -->

  <xsl:template match='terrain'>
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
    <html>
      <head>
        <title>Puissance 4 - M1 IC</title>
      </head>
      <body>
        <p><b>Projet de puissance 4</b></p>
        <p><i>Mathis Ruffieux - 2021</i></p>
        <table style="border: 2px solid black">
          <xsl:for-each select="ligne">
            <tr>
              <xsl:for-each select="colonne">
                <td>
                  <svg height="80" width="80">
                    <xsl:if test=". = 'vide'">
                      <circle cx="40" cy="40" r="35" stroke="black" stroke-width="2" fill="none"/>
                    </xsl:if>
                    <xsl:if test=". = 'joueur1'">
                      <circle cx="40" cy="40" r="35" stroke="black" stroke-width="2" fill="crimson"/>
                    </xsl:if>
                    <xsl:if test=". = 'joueur2'">
                      <circle cx="40" cy="40" r="35" stroke="black" stroke-width="2" fill="gold"/>
                    </xsl:if>
                  </svg>
                </td>
                
              </xsl:for-each>
            </tr>
          </xsl:for-each>
        </table>


        <!-- On test si il y a une victoire -->

        <!--
        <xsl:variable name="victoireJoueur1" as="xs:boolean" select="false()"/>-->

        <xsl:for-each select="ligne">

          <!-- On recupere l'Id pour chaque ligne dans une variable
          -->
          <xsl:variable name="IdLigne">
            <xsl:value-of select="@id"/>
          </xsl:variable>

          <xsl:for-each select="colonne">

            <!-- On recupere l'Id pour chaque colonne dans une variable
            -->
            <xsl:variable name="IdColonne">
              <xsl:value-of select="@id"/>
            </xsl:variable>

            <!-- On test une victoire en ligne
            le "." correspond soit à "joueur1" soit à "joueur2" soit à "vide"
            -->
            <xsl:if test="../colonne[@id=($IdColonne+1)] = . and ../colonne[@id=($IdColonne+2)] = . and ../colonne[@id=($IdColonne+3)] = .">
              <xsl:if test=". = 'joueur1'">
                <p>Victoire du <font color ="crimson">Joueur 1</font> en ligne !</p>

                <!-- On ne peut pas redefinir une variable !!
                <xsl:variable name="victoireJoueur1" as="xs:boolean" select="true()"/>-->

              </xsl:if>
              <xsl:if test=". = 'joueur2'">
                <p>Victoire du <font color ="orange">Joueur 2</font> en ligne !</p>
              </xsl:if>
            </xsl:if>

            <!-- On test une victoire en colonne
            -->
            <xsl:if test="../../ligne[@id=($IdLigne+1)]/colonne[@id=$IdColonne] = . and ../../ligne[@id=($IdLigne+2)]/colonne[@id=$IdColonne] = . and ../../ligne[@id=($IdLigne+3)]/colonne[@id=$IdColonne] = . ">
              <xsl:if test=". = 'joueur1'">
                <p>Victoire du <font color ="crimson">Joueur 1</font> en colonne !</p>
              </xsl:if>
              <xsl:if test=". = 'joueur2'">
                <p>Victoire du <font color ="orange">Joueur 2</font> en colonne !</p>
              </xsl:if>
            </xsl:if>

            <!-- On test une victoire en diagonale (haut gauche -> bas droite)
            -->
            <xsl:if test="../../ligne[@id=($IdLigne+1)]/colonne[@id=$IdColonne+1] = . and ../../ligne[@id=($IdLigne+2)]/colonne[@id=$IdColonne+2] = . and ../../ligne[@id=($IdLigne+3)]/colonne[@id=$IdColonne+3] = . ">
              <xsl:if test=". = 'joueur1'">
                <p>Victoire du <font color ="crimson">Joueur 1</font> en diagonale ! (haut gauche -> bas droite)</p>
              </xsl:if>
              <xsl:if test=". = 'joueur2'">
                <p>Victoire du <font color ="orange">Joueur 2</font> en diagonale ! (haut gauche -> bas droite)</p>
              </xsl:if>
            </xsl:if>

            <!-- On test une victoire en diagonale (bas gauche -> haut droite)
            -->
            <xsl:if test="../../ligne[@id=($IdLigne+1)]/colonne[@id=$IdColonne - 1] = . and ../../ligne[@id=($IdLigne+2)]/colonne[@id=$IdColonne - 2] = . and ../../ligne[@id=($IdLigne+3)]/colonne[@id=$IdColonne - 3] = . ">
              <xsl:if test=". = 'joueur1'">
                <p>Victoire du <font color ="crimson">Joueur 1</font> en diagonale ! (bas gauche -> haut droite)</p>
              </xsl:if>
              <xsl:if test=". = 'joueur2'">
                <p>Victoire du <font color ="orange">Joueur 2</font> en diagonale ! (bas gauche -> haut droite)</p>
              </xsl:if>
              
            </xsl:if>

            <xsl:if test="../../ligne[@id=($IdLigne+1)]/colonne[@id=$IdColonne] = 'vide'">
              <xsl:if test=". = 'joueur1'">
                <p>Le <font color ="crimson">Joueur 1</font> a triche ! Jeton volant</p>
              </xsl:if>
              <xsl:if test=". = 'joueur2'">
                <p>Le <font color ="orange">Joueur 2</font> a triche ! Jeton volant</p>
              </xsl:if>
            </xsl:if>

          </xsl:for-each>
        </xsl:for-each>



        

        <!-- Nombre de coups du joueur 1
        -->
        <xsl:variable name="nbJoueur1">
          <xsl:value-of select="count(ligne/colonne[text() = 'joueur1'])"/>
        </xsl:variable>

        <!-- Nombre de coups du joueur 2
        -->
        <xsl:variable name="nbJoueur2">
          <xsl:value-of select="count(ligne/colonne[text() = 'joueur2'])"/>
        </xsl:variable>

        <!-- Nombre de coups vide
        -->
        <xsl:variable name="nbVide">
          <xsl:value-of select="count(ligne/colonne[text() = 'vide'])"/>
        </xsl:variable>

        <!-- Pour tester si les joueurs ont trichés
        -->
        <xsl:if test="$nbJoueur2 > $nbJoueur1">
          <p>Le <font color ="orange">Joueur 2</font> a triche ! (nb coups Joueur2 > nb coups Joueur1)</p>
        </xsl:if>
        
        <xsl:if test="$nbJoueur1 > $nbJoueur2 + 1">
          <p>Le <font color ="crimson">Joueur 1</font> a triche ! (nb coups Joueur1 > nb coups Joueur2 + 1)</p>
        </xsl:if>

        <!-- Pour tester si le terrain est remplit
        -->
        <xsl:if test="$nbVide = 0">
          <p>Le terrain est remplit : La partie est nulle si il n'y a pas de victoire.</p>
        </xsl:if>

        <!--
        <xsl:if test="$victoireJoueur1 = true()">
          <p>victoire Joueur 1 = true</p>
        </xsl:if>-->


        <!-- Pour tester si il y a un jeton volant : 
        <xsl:for-each select="ligne">
          <xsl:for-each select="colonne">
            <xsl:if test=". = 'joueur1'">
                <p>Victoire du <font color ="crimson">Joueur 1</font> en diagonale ! (haut gauche -> bas droite)</p>
              </xsl:if>
          </xsl:for-each>
        </xsl:for-each>-->
        

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>