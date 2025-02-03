<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 

  <xsl:output method="xml" indent="yes"/>

  <!-- Pour générer html :
  xsltproc transform_style.xslt xml/valide2.xml > html/3.html
   -->

  <xsl:template match='terrain'>
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
    <html>

<head>
  <meta charset="UTF-8"/>
  <title>Puissance 4 - M1 IC</title>
  <link rel="stylesheet" href="../css/style.css"/>
  <script src="https://cdn.jsdelivr.net/npm/kute.js@2.1.2/dist/kute.min.js">.</script>

</head>
      <body>
        <section class="top">
          <h1>Projet de Puissance 4</h1>
          <p>Mathis Ruffieux - 2021</p>
        </section>
        <section class="middle">
        <table style="border: 0px solid black">
          <xsl:for-each select="ligne">
            <tr>
              <xsl:for-each select="colonne">
                <td>
                  <svg height="80" width="80">
                    <xsl:if test=". = 'vide'">
                      <circle cx="40" cy="40" r="35" stroke="#3d405b" stroke-width="2" fill="#3d405b"/>
                    </xsl:if>
                    <xsl:if test=". = 'joueur1'">
                      <circle cx="40" cy="40" r="35" stroke="#3d405b" stroke-width="2" fill="crimson"/>
                    </xsl:if>
                    <xsl:if test=". = 'joueur2'">
                      <circle cx="40" cy="40" r="35" stroke="#3d405b" stroke-width="2" fill="gold"/>
                    </xsl:if>
                  </svg>
                </td>
                
              </xsl:for-each>
            </tr>
          </xsl:for-each>
        </table>

        <div class="wave">
        <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
          <path d="M321.39,56.44c58-10.79,114.16-30.13,172-41.86,82.39-16.72,168.19-17.73,250.45-.39C823.78,31,906.67,72,985.66,92.83c70.05,18.48,146.53,26.09,214.34,3V0H0V27.35A600.21,600.21,0,0,0,321.39,56.44Z" class="shape-fill"></path>
        </svg>
    </div>

        <div class="blob-motion">
    <svg id="visual" viewBox="0 0 900 500" width="900" height="500" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
      <g transform="translate(490.9611521058816 220.31935734979987)"><path id="blob1" d="M232.1 -125.1C271.4 -66 253.5 35 205.2 113.2C157 191.3 78.5 246.7 -23.9 260.5C-126.3 274.3 -252.6 246.5 -305.4 165.7C-358.2 84.8 -337.6 -49.1 -274.5 -122C-211.3 -194.9 -105.7 -206.8 -4.6 -204.2C96.4 -201.5 192.8 -184.3 232.1 -125.1" fill="#767cb0"></path></g>

      <g transform="translate(475.8359258663696 237.1383191638477)" style="visibility: hidden"><path id="blob2" d="M216.8 -92.6C276.6 -21.7 317.5 92.7 278.3 155.2C239 217.7 119.5 228.3 -3.4 230.3C-126.3 232.3 -252.6 225.5 -309.3 152.9C-366 80.3 -353.2 -58.1 -290 -131C-226.9 -203.9 -113.4 -211.3 -17.5 -201.3C78.5 -191.2 157 -163.6 216.8 -92.6" fill="#767cb0"></path></g>
    </svg>

    <script type="text/javascript">
      const tween = KUTE.fromTo(
        '#blob1',
        {path: '#blob1'},
        {path: '#blob2'},
        {repeat: 999, duration: 3000, yoyo: true},
        )
      tween.start();
    </script>
    </div>

        </section>

        <div class="spacer layer1">.</div>

        <section class="bottom">
    <h1>Interpretation :</h1>

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
                <p>Victoire du <font color ="darkred">Joueur 1</font> en ligne !</p>

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
                <p>Victoire du <font color ="darkred">Joueur 1</font> en colonne !</p>
              </xsl:if>
              <xsl:if test=". = 'joueur2'">
                <p>Victoire du <font color ="orange">Joueur 2</font> en colonne !</p>
              </xsl:if>
            </xsl:if>

            <!-- On test une victoire en diagonale (haut gauche -> bas droite)
            -->
            <xsl:if test="../../ligne[@id=($IdLigne+1)]/colonne[@id=$IdColonne+1] = . and ../../ligne[@id=($IdLigne+2)]/colonne[@id=$IdColonne+2] = . and ../../ligne[@id=($IdLigne+3)]/colonne[@id=$IdColonne+3] = . ">
              <xsl:if test=". = 'joueur1'">
                <p>Victoire du <font color ="darkred">Joueur 1</font> en diagonale ! (haut gauche -> bas droite)</p>
              </xsl:if>
              <xsl:if test=". = 'joueur2'">
                <p>Victoire du <font color ="orange">Joueur 2</font> en diagonale ! (haut gauche -> bas droite)</p>
              </xsl:if>
            </xsl:if>

            <!-- On test une victoire en diagonale (bas gauche -> haut droite)
            -->
            <xsl:if test="../../ligne[@id=($IdLigne+1)]/colonne[@id=$IdColonne - 1] = . and ../../ligne[@id=($IdLigne+2)]/colonne[@id=$IdColonne - 2] = . and ../../ligne[@id=($IdLigne+3)]/colonne[@id=$IdColonne - 3] = . ">
              <xsl:if test=". = 'joueur1'">
                <p>Victoire du <font color ="darkred">Joueur 1</font> en diagonale ! (bas gauche -> haut droite)</p>
              </xsl:if>
              <xsl:if test=". = 'joueur2'">
                <p>Victoire du <font color ="orange">Joueur 2</font> en diagonale ! (bas gauche -> haut droite)</p>
              </xsl:if>
              
            </xsl:if>

            <xsl:if test="../../ligne[@id=($IdLigne+1)]/colonne[@id=$IdColonne] = 'vide'">
              <xsl:if test=". = 'joueur1'">
                <p>Le <font color ="darkred">Joueur 1</font> a triche ! Jeton volant</p>
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
          <p>Le <font color ="darkred">Joueur 1</font> a triche ! (nb coups Joueur1 > nb coups Joueur2 + 1)</p>
        </xsl:if>

        <!-- Pour tester si le terrain est remplit
        -->
        <xsl:if test="$nbVide = 0">
          <p>Le terrain est remplit : La partie est nulle si il n'y a pas de victoire.</p>
        </xsl:if>


        <svg id="circles_background" viewBox="0 0 900 500" width="900" height="500" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">
        <rect width="900" height="500" fill="#bc4749"></rect>
        <g>
          <g transform="translate(641 219)">
            <path d="M93.3 -33.3C104.1 2.7 84.2 45.6 51.8 68.6C19.3 91.5 -25.8 94.5 -57.3 73C-88.8 51.4 -106.9 5.4 -95.1 -32.1C-83.3 -69.6 -41.6 -98.5 -0.2 -98.5C41.3 -98.4 82.6 -69.4 93.3 -33.3Z" stroke="#e07a5f" fill="none" stroke-width="20">
            </path></g>
          <g transform="translate(104 426)">
            <path d="M67.6 -22.1C76.1 4.4 63.8 37.6 41.6 52.8C19.3 67.9 -12.8 64.9 -34.8 48.7C-56.7 32.6 -68.5 3.3 -61 -21.8C-53.5 -46.8 -26.7 -67.6 1.4 -68C29.5 -68.5 59 -48.6 67.6 -22.1Z" stroke="#e07a5f" fill="none" stroke-width="20"></path></g>
          <g transform="translate(343 245)">
            <path d="M50.9 -17.3C57.5 3.8 48.6 29.2 30.1 43.1C11.5 56.9 -16.6 59.2 -35.1 46.3C-53.7 33.3 -62.6 5 -55.2 -17.2C-47.7 -39.5 -23.9 -55.8 -0.9 -55.5C22.1 -55.2 44.3 -38.4 50.9 -17.3Z" stroke="#e07a5f" fill="none" stroke-width="20"></path></g>
        </g>
      </svg>

        </section>

      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>