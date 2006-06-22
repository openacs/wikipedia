ad_page_contract {
} {
} -properties {
}

set WIKIPEDIA_BASE "http://%s.wikipedia.org"
set WIKIPEDIA_URL [format "$WIKIPEDIA_BASE" $xlang]
set WIKIPEDIA_SEARCH_URL "$WIKIPEDIA_URL/wiki"
set STRING_MAX_LENGTH 5000

set timeout 30
set depth 3
set redirect_url "error.tcl"
set result ""
set toshow ""

switch -glob $xlang {
   "es"      {set s_es "selected"; set s_ca "";         set s_en "";         set s_fr "";
              set s_de "";         set s_pt "";         set s_it "";}
   "ca"      {set s_es "";         set s_ca "selected"; set s_en "";         set s_fr "";
              set s_de "";         set s_pt "";         set s_it "";}
   "en"      {set s_es "";         set s_ca "";         set s_en "selected"; set s_fr "";
              set s_de "";         set s_pt "";         set s_it "";}
   "fr"      {set s_es "";         set s_ca "";         set s_en "";         set s_fr "selected";
              set s_de "";         set s_pt "";         set s_it "";}
   "de"      {set s_es "";         set s_ca "";         set s_en "";         set s_fr "";
              set s_de "selected"; set s_pt "";         set s_it "";}
   "pt"      {set s_es "";         set s_ca "";         set s_en "";         set s_fr "";
              set s_de "";         set s_pt "selected"; set s_it "";}
   "it"      {set s_es "";         set s_ca "";         set s_en "";         set s_fr "";
              set s_de "";         set s_pt "";         set s_it "selected";}
   default   {set s_es "";         set s_ca "";         set s_en "selected"; set s_fr "";
              set s_de "";         set s_pt "";         set s_it "";}
}

set user_id [ad_conn user_id]
set urltoform [ad_conn url]
set url ""
set urlfull ""
if {$whatsearch ne ""} {
  set whatsearch [string toupper [string index $whatsearch 0]][string range $whatsearch 1 end]
  set whatsearch_cod [ns_urlencode $whatsearch]
  set url [format "$WIKIPEDIA_SEARCH_URL/%s" $whatsearch_cod]
  set urlfull "/wikipedia/search?xlang=$xlang&whatsearch=$whatsearch_cod"

  if {[catch {set rawtext [ns_httpget $url $timeout $depth]} result]} {
    #ERROR
    set toshow "Temporalment fora de servei"
  } else {

    set fn "/tmp/wikipedia_$user_id"
    set fd [open $fn w]
    puts -nonewline $fd $rawtext
    close $fd    
    set fd [open $fn r]
    fconfigure $fd -encoding "utf-8"
    set rawtext [read $fd [file size $fn]]
    close $fd
    file delete $fn

    set L [string length $rawtext]
    set start [string first "<!-- start content -->" $rawtext]
    if {$start <= -1} {
      set start 0
    }
    set end [string first "<!-- end content -->" $rawtext]
    set end [expr $end - 1]
    if {$end <= -1} {
      set end $L
    }

    set rawtext [string range $rawtext $start $end]    
    set inter "href=\"\?search=Buscar\\&xlang=$xlang\\&whatsearch="
    regsub -nocase -line -all {href=\"/wiki/} $rawtext $inter rawtext           
    regsub -nocase -line -all {href=\"/w/}  $rawtext "href=\"$WIKIPEDIA_URL/w/" rawtext
    
    set toshow $rawtext
    if {$see ne "full"} {
      if {[string length $toshow] > $STRING_MAX_LENGTH} {
        set toshow [string range $toshow 0 $STRING_MAX_LENGTH]
        set toshow "$toshow \"...\n"
      }
    }    
  }
} 

