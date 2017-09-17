#!/usr/bin/perl -w
use File::Spec;

if ( $#ARGV != 2 ) {
    usage();
    exit(1);
}
my ($option, $src, $dst) = @ARGV;
if ( ! File::Spec->file_name_is_absolute($src) ) {
    $src = File::Spec->rel2abs($src);
}
if ( ! File::Spec->file_name_is_absolute($dst) ) {
    $dst = File::Spec->rel2abs($dst);
}

if ( ! -d $src ) {
    print "Directory not exists: $src\n";
    usage();
    exit(3);
}
if ( ! -d $dst ) {
    print "Directory not exists: $dst\n";
    usage();
    exit(4);
}
if ( $option eq "make" ) {
    @files = get_files($src);
    foreach my $file ( @files ) {
        my $newfile = "$dst/$file";
        my $oldfile = "$src/$file";
        print "$newfile: ";
        if ( -l $newfile ) {
            my $pathto = readlink($newfile) or die "readlink failed: $!";
            if ( $pathto eq $oldfile ) {
                print "skip same link to $oldfile";
            } else {
                unlink($newfile) or die "unlink failed: $!";
                symlink($oldfile, $newfile) or die "symlink failed: $!";
                print "replaced from $pathto";
            }
        } elsif ( -f $newfile ) {
            print "skip existing file";
        } elsif ( -d $newfile ) {
            print "skip existing directory";
        } elsif ( ! -e $newfile ) {
            symlink($oldfile, $newfile) or die "symlink failed: $!";
            print "created to $oldfile";
        } else {
            print "skip unknown file type";
        }
        print "\n";
    }
    exit(0);
    
} elsif ( $option eq "drop" ) {
    print "This feature not implemented. Drop the links manually.\n";
    exit(5);
    
} else {
    print "Unknown option: $option\n";
    usage();
    exit(2);
}

sub get_files {
    my ($dir) = @_;
    opendir(DIR, $dir) or die "Couldn't open dir: $dir";
    my @files = ();
    foreach my $file ( readdir(DIR) ) {
        if ( -f "$dir/$file" ) {
            push @files, $file;
        }
    }
    closedir(DIR);
    return @files;
}

sub usage {
    print
"Usage:\n\n",
"  $0 <option> <src> <dst>\n",
"\n",
"Options:\n\n",
"  make - for each file in <src> directory to make symlink with same name\n",
"         in <dst> directory\n",
"  drop - drop symlink from <dst> directory for each file in <src> directory\n",
"\n",
"Examples:\n\n",
"  $0 make T2-Droid/scripts ~/games/x3/scripts\n\n",
"  $0 drop SecurityController/t ~/games/x3/t\n\n";
}

