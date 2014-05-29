#!/usr/bin/perl

# Script to parse a sql file and generate the json files to be used by content provider generator
# author: Felipe Silveira (felipesilveira.com.br)

use strict;
use XML::Simple;
use Data::Dumper;

my $input_file = $ARGV[0] or die "Usage: sql2json.pl <sql_file> \n";

open(IN_SQL, $input_file) or die "Could not open '$input_file' $!\n";

open (OUT, ">dummy") or die "The script must to have permissions to write in the current dir.\n";

mkdir ("input");

while (my $line = <IN_SQL>) {
  chomp $line;
  $line =~ s/\s+/ /gi;
  my @fields = split " " , $line;
 
  if($line =~ m/CREATE TABLE ([A-Za-z0-9]+)/gi) { # its a create table line
  		print "found table ".$1."\n";
  		my $table = $1;
  		print OUT "]\n";
    	print OUT "}\n";
    	
  		close(OUT);
  		open (OUT, ">input/".$table.".json");
  		print OUT "{\n";
    	print OUT "    \"fields\": [\n";
  } elsif ($line =~ m/CREATE INDEX/gi) { # its a create index line
  
  	# do nothing here
  
  } elsif ($fields[0] =~ m/^[a-zA-Z]+/gi) { # its a field
    	my $type = $fields[1];
  		$type =~ s/\([0-9]*\)//gi;
  		$type =~ s/;//gi;
  		$type = ucfirst(lc($type));

  		if(($type eq "Varchar") || ($type eq "Text")) {
  			$type = "String";
  		}
  		if($type eq "Int") {
  			$type = "Integer";
  		}
  		print OUT "    {\n";
  		print OUT "        \"name\": \"" . $fields[0] . "\",\n";
  		print OUT "        \"type\": \"" . $type . "\",\n";
  		if ($fields[2] =~ m/DEFAULT/gi) {
  			$fields[3] =~ s/'//gi;
  			$fields[3] =~ s/;//gi;
  			print OUT "        \"default_value\": \"" . $fields[3] . "\",\n";
  		}
  		if ($line =~ m/NOT NULL/gi) {
  			print OUT "        \"nullable\": false,\n";
  		}
  		print OUT "    },\n";
  }
  
}

unlink ("dummy");

print OUT "    ]\n";
print OUT "}\n";
close IN_SQL;
close OUT;

print "\nInput files created in input dir.\n";
print "Now, run java -jar android-contentprovider-generator-1.7.2-bundle.jar -i input -o <output folder>\n\n";

