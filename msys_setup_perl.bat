if %sentinel% NEQ __sentinel__ exit

set strawberryperl_url=http://strawberryperl.com/download/5.12.1.0
call %tmp%\wget_and_unpack1.bat %strawberryperl_url% strawberry-perl-5.12.1.0-portable.zip %perl_dir%


echo #!/bin/sh                                                                   >  %msys_dir%\bin\perl
echo case $# in                                                                  >> %msys_dir%\bin\perl
echo 0) exec /perl/perl/bin/perl ;;                                              >> %msys_dir%\bin\perl
echo 1) exec /perl/perl/bin/perl "$1" ;;                                         >> %msys_dir%\bin\perl
echo 2) exec /perl/perl/bin/perl "$1" "$2" ;;                                    >> %msys_dir%\bin\perl
echo 3) exec /perl/perl/bin/perl "$1" "$2" "$3" ;;                               >> %msys_dir%\bin\perl
echo 4) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" ;;                          >> %msys_dir%\bin\perl
echo 5) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" ;;                     >> %msys_dir%\bin\perl
echo 6) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" "$6" ;;                >> %msys_dir%\bin\perl
echo 7) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" "$6" "$7" ;;           >> %msys_dir%\bin\perl
echo 8) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" ;;      >> %msys_dir%\bin\perl
echo 9) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" ;; >> %msys_dir%\bin\perl
echo 10) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" ;; >> %msys_dir%\bin\perl
echo 11) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" ;; >> %msys_dir%\bin\perl
echo 12) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "$12" ;; >> %msys_dir%\bin\perl
echo 13) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "$12" "$13" ;; >> %msys_dir%\bin\perl
echo 14) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "$12" "$13" "$14" ;; >> %msys_dir%\bin\perl
echo 15) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "$12" "$13" "$14" "$15" ;; >> %msys_dir%\bin\perl
echo 19) exec /perl/perl/bin/perl "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "$12" "$13" "$14" "$15" "$16" "$17" "$18" "$19" ;; >> %msys_dir%\bin\perl
echo *) echo error: too many arguments for perl wrapper script: $#                   >> %msys_dir%\bin\perl
echo esac                                                                        >> %msys_dir%\bin\perl


echo export PATH=/perl/perl/site/bin:/perl/perl/bin:$PATH:/perl/c/bin >  %msys_dir%\etc\profile.d\perl.sh



set perl_url=http://cpansearch.perl.org/src/MAKAMAKA/Text-CSV-1.20/lib/Text

if not exist %perl_dir%\perl\site\lib\Text mkdir %perl_dir%\perl\site\lib\Text
call %tmp%\wget_and_copy.bat %perl_url% CSV.pm %perl_dir%\perl\site\lib\Text
call %tmp%\wget_and_copy.bat %perl_url% CSV_PP.pm %perl_dir%\perl\site\lib\Text
