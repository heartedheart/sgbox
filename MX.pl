#!/usr/bin/perl
use strict;
use warnings;
use 5.010;
use Data::Dumper;
use Getopt::Long;
#THIS SCRIPT CODED BY G66K
#LICENSE TO Mr.Anob
#KEEP IT PRIVATE OR SELL IT AND BECOME RICH :)


if($#ARGV != 1){
  say("$0 InputFile Regexdomain ");
  say("$0 Mailfile.txt google ");
  exit(0);
}
  my ($file,$regex) = @ARGV;
if($regex =~ /google/i){
	$regex = 'alt3.gmail-smtp-in.l.google.com'
}
my @emails = fileHandle($file);
       foreach my $email (@emails){
          chomp($email);
     say("Checking: ".$email);
    
 mxQuery($email,$regex) if defined $email;   
  }



sub mxQuery{
 my $email = $_[0];
 my $regex = $_[1];    
 my @domain = split('@',$email);
 my $domain = $domain[1];

eval{

	my @mxs = `nslookup -q=mx $domain`;
	my @matches = grep { /$regex/i } @mxs;

	if (@matches){
		say("$regex => $email");
	    saveRes($email,$regex);       
}

};

if($@){
 say("bad Email: $email");
}

}
 
 sub fileHandle {
   my ($file) = $_[0];
   open(my $fn,'<',$file) or die $!;
   my @mails = <$fn>;
   close($fn);
return @mails;
}
sub saveRes {
    my $email = $_[0];
	my $regex = $_[1];
    open(my $fn,'>>',"$regex.txt") or die $!;
    print $fn "$email\n";
    close($fn);
}