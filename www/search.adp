<master>
<link rel="stylesheet" type="text/css" href="/resources/dotlrn/dotlrn-master.css" media="all">

<FORM action="@urltoform@" method="post">
  #dotlrn-wikipedia.entry#:
  <input type="text" size="20" maxlength=100" name="whatsearch" value="@whatsearch@" />
  <SELECT NAME="xlang">
    <OPTION VALUE="es" label="Espa�ol"    @s_es@>Espa�ol
    <OPTION VALUE="ca" label="Catal�"     @s_ca@>Catal�
    <OPTION VALUE="en" label="English"    @s_en@>English
    <OPTION VALUE="fr" label="Fran�ais"   @s_fr@>Fran�ais
    <OPTION VALUE="de" label="Deutsch"    @s_de@>Deutsch
    <OPTION VALUE="pt" label="Portugu�s"  @s_pt@>Portugu�s
    <OPTION VALUE="it" label="Italiano"   @s_it@>Italiano
   </SELECT>
  <input type="submit" name="search" value="#dotlrn-wikipedia.search#" />
</FORM>

<if @toshow@ ne "">
  <HR>
  @toshow;noquote@
</if>
