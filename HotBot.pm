# HotBot.pm
# by Wm. L. Scheding and Martin Thurn
# Copyright (C) 1996-1998 by USC/ISI
# $Id: HotBot.pm,v 1.67 2001/12/17 19:52:32 mthurn Exp $

=head1 NAME

WWW::Search::HotBot - backend for searching hotbot.lycos.com

=head1 SYNOPSIS

  use WWW::Search;
  my $oSearch = new WWW::Search('HotBot');
  my $sQuery = WWW::Search::escape_query("+sushi restaurant +Columbus Ohio");
  $oSearch->native_query($sQuery);
  while (my $oResult = $oSearch->next_result())
    { print $oResult->url, "\n"; }

=head1 DESCRIPTION

This class is a HotBot specialization of WWW::Search.
It handles making and interpreting HotBot searches
F<http://www.hotbot.com>.

This class exports no public interface; all interaction should
be done through L<WWW::Search> objects.

By default, WWW::Search::HotBot uses hotbot.com's "advanced search"
interface.  If you want to perform a query with the same default
options as if a user typed it in the browser window (i.e. at
http://www.hotbot.com), call $oSearch->gui_query($sQuery) instead of
->native_query().

The default behavior is for HotBot to look for "any of" the query
terms:

  $oSearch->native_query(escape_query('Dorothy Oz'));

If you want "all of", call native_query like this:

  $oSearch->native_query(escape_query('Dorothy Oz'), {'SM' => 'MC'});

If you want to send HotBot a boolean phrase, call native_query like this:

  $oSearch->native_query(escape_query('Oz AND Dorothy NOT Australia'), {'SM' => 'B'});

See below for other query-handling options.

=head1 OPTIONS

The following search options can be activated by sending a hash as the
second argument to native_query().

=head2 Format / Treatment of Query Terms

The default is logical OR of all the query terms.

=over 2

=item   {'SM' => 'MC'}

"Must Contain": logical AND of all the query terms.

=item   {'SM' => 'SC'}

"Should Contain": logical OR of all the query terms.
This is the default.

=item   {'SM' => 'B'}

"Boolean": the entire query is treated as a boolean expression with
AND, OR, NOT, and parentheses.

=item   {'SM' => 'name'}

The entire query is treated as a person's name.

=item   {'SM' => 'phrase'}

The entire query is treated as a phrase.

=item   {'SM' => 'title'}

The query is applied to the page title.  (I assume the logical OR of
the query terms will be applied to the page title.)

=item   {'SM' => 'url'}

The query is assumed to be a URL, and the results will be pages that
link to the query URL.

=back

=head2 Restricting Search to a Date Range

The default is no date restrictions.

=over 2

=item {'date' => 'within', 'DV' => 90}

Only return pages updated within 90 days of today.  
(Substitute any integer in place of 90.)

=item {'date' => 'range', 'DR' => 'newer', 'DY' => 97, 'DM' => 12, 'DD' => 25}

Only return pages updated after Christmas 1997.
(Substitute any year, month, and day for 97, 12, 25.)

=item {'date' => 'range', 'DR' => 'older', 'DY' => 97, 'DM' => 12, 'DD' => 25}

Only return pages updated before Christmas 1997.
(Substitute any year, month, and day for 97, 12, 25.)

=back

=head2 Restricting Search to a Geographic Area

The default is no restriction to geographic area.

=over 2

=item {'RD' => 'AN'}

Return pages from anywhere.  This is the default.

=item {'RD' => 'DM', 'Domain' => 'microsoft.com, .cz'}

Restrict search to pages located in the listed domains.
(Substitute any list of domain substrings.)

=item {'RD' => 'RG', 'RG' => '.com'}

Restrict search to North American commercial web sites.

=item {'RD' => 'RG', 'RG' => '.edu'}

Restrict search to North American educational web sites.

=item {'RD' => 'RG', 'RG' => '.gov'}

Restrict search to United Stated Government web sites.

=item {'RD' => 'RG', 'RG' => '.mil'}

Restrict search to United States military commercial web sites.

=item {'RD' => 'RG', 'RG' => '.net'}

Restrict search to North American '.net' web sites.

=item {'RD' => 'RG', 'RG' => '.org'}

Restrict search to North American organizational web sites.

=item {'RD' => 'RG', 'RG' => 'NA'}

"North America": Restrict search to all of the above types of web sites.

=item {'RD' => 'RG', 'RG' => 'AF'}

Restrict search to web sites in Africa.

=item {'RD' => 'RG', 'RG' => 'AS'}

Restrict search to web sites in India and Asia.

=item {'RD' => 'RG', 'RG' => 'CA'}

Restrict search to web sites in Central America.

=item {'RD' => 'RG', 'RG' => 'DU'}

Restrict search to web sites in Oceania.

=item {'RD' => 'RG', 'RG' => 'EU'}

Restrict search to web sites in Europe.

=item {'RD' => 'RG', 'RG' => 'ME'}

Restrict search to web sites in the Middle East.

=item {'RD' => 'RG', 'RG' => 'SE'}

Restrict search to web sites in Southeast Asia.

=back

=head2 Requesting Certain Multimedia Data Types

The default is not specifically requesting any multimedia types
(presumably, this will NOT restrict the search to NON-multimedia
pages).

=over 2

=item {'FAC' => 1}

Return pages which contain Adobe Acrobat PDF data.

=item {'FAX' => 1}

Return pages which contain ActiveX.

=item {'FJA' => 1}

Return pages which contain Java.

=item {'FJS' => 1}

Return pages which contain JavaScript.

=item {'FRA' => 1}

Return pages which contain audio.

=item {'FSU' => 1, 'FS' => '.txt, .doc'}

Return pages which have one of the listed extensions.
(Substitute any list of DOS-like file extensions.)

=item {'FSW' => 1}

Return pages which contain ShockWave.

=item {'FVI' => 1}

Return pages which contain images.

=item {'FVR' => 1}

Return pages which contain VRML.

=item {'FVS' => 1}

Return pages which contain VB Script.

=item {'FVV' => 1}

Return pages which contain video.

=back

=head2 Requesting Pages at Certain Depths on Website

The default is pages at any level on their website.

=over 2

=item {'PS'=>'A'}

Return pages at any level on their website.
This is the default.

=item {'PS' => 'D', 'D' => 3 }

Return pages within 3 links of "top" page of their website.
(Substitute any integer in place of 3.)

=item {'PS' => 'F'}

Only return pages that are the "top" page of their website.

=back

=head1 SEE ALSO

To make new back-ends, see L<WWW::Search>.

=head1 CAVEATS

When www.hotbot.com reports a "Mirror" URL, WWW::Search::HotBot
ignores it.  Therefore, the number of URLs returned by
WWW::Search::HotBot might not agree with the value returned in
approximate_result_count.

=head1 BUGS

Please tell the author if you find any!

=head1 AUTHOR

As of 1998-02-02, C<WWW::Search::HotBot> is maintained by Martin Thurn
(MartinThurn@iname.com).

C<WWW::Search::HotBot> was originally written by Wm. L. Scheding,
based on C<WWW::Search::AltaVista>.

=head1 LEGALESE

THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

=head1 VERSION HISTORY

If it is not listed here, then it was not a meaningful nor released revision.

=head2 2.25, 2001-12-17

FIX for new URL output format with date; delete unused code; get next page of results

=head2 2.24, 2001-10

Massive re-write using new website parameters and HTML::TreeBuilder

=head2 2.23, 2001-07-19

Tweak pattern for result-count; set agent_name to something that works

=head2 2.21, 2000-12-11

new URL for advanced search

=head2 2.19, 2000-10-11

added AM1=MC to all URLs in GUI mode (hotbot.com seems to "randomly"
add this if you search manually at their site)

=head2 2.18, 2000-06-26

fix for only one page of gui results; and "next" link in new place

=head2 2.17, 2000-05-24

was still missing first URL of non-gui(?) results!

=head2 2.16, 2000-05-17

was missing first URL of gui results

=head2 2.15, 2000-04-03

fixed gui_query()

=head2 2.14, 2000-02-01

testing now uses WWW::Search::Test module

=head2 2.13, 2000-01-31

bugfix: was missing title

=head2 2.12, 2000-01-19

new function gui_query(), and handle output from it

=head2 2.10, 1999-12-22

handle new result format

=head2 2.09, 1999-12-15

handle new result count format

=head2 2.08, 1999-12-10

handle new output format

=head2 2.07, 1999-11-12

BUGFIX for domain-limited URL parsing (thanks to Leon Brocard)

=head2 2.06, 1999-10-18

www.hotbot.com changed their output format slightly;
now uses strip_tags() on title and description

=head2 2.05, 1999-10-05

now uses hash_to_cgi_string(); new test cases

=head2 2.03, 1999-09-28

BUGFIX: was missing the "Next page" link sometimes.

=head2 2.02, 1999-08-17

Now is able to parse "URL-only" format (i.e. {'DE' => 0}) and "brief
description" format (i.e. {'DE' => 1}) if the user so desires.

=head2 1.34, 1999-07-01

New test cases.

=head2 1.32, 1999-06-20

Now unescapes the URLs before returning them.

=head2 1.31, 1999-06-11

www.hotbot.com changed their output format ever so slightly.  (Thanks
to Jim jsmyser@bigfoot.com for pointing it out)

=head2 1.30, 1999-04-12

BUG FIX: results for domain-limited search were not parsed.  (Thanks to
Christopher York yorkc@ccwf.cc.utexas.edu for pointing it out)

=head2 1.29, 1999-02-22

www.hotbot.com changed their output format.  (Thanks to Tim Chklovski
timc@mit.edu for pointing it out)

=head2 1.27, 1998-11-06

HotBot changed their output format(?).
HotBot.pm now uses hotbot.com's text-only search results format.
Minor documentation changes.

=head2 1.25, 1998-09-11

HotBot changed their output format ever so slightly.
Documentation added for all known HotBot query options!

=head2 1.23

Better documentation for boolean queries.  (Thanks to Jason Titus jason_titus@odsnet.com)

=head2 1.22

www.hotbot.com changed their output format.

=head2 1.21

www.hotbot.com changed their output format.

=head2 1.17

www.hotbot.com changed their search script location and output format on 1998-05-21.
Also, as many as 6 fields of each SearchResult are now filled in.

=head2 1.13

Fixed the maximum_to_retrieve off-by-one problem.
Updated test cases.

=head2 1.12

www.hotbot.com does not do truncation. Therefore, if the query
contains truncation characters (i.e. '*' at end of words), they are
simply deleted before the query is sent to www.hotbot.com.

=head2 1.11, 1998-02-05

Fixed and revamped by Martin Thurn.

=cut

#####################################################################

package WWW::Search::HotBot;

require Exporter;
@EXPORT = qw( );
@EXPORT_OK = qw( );
@ISA = qw( WWW::Search Exporter );

$VERSION = '2.25';
$MAINTAINER = 'Martin Thurn <MartinThurn@iname.com>';

use Carp ();
use WWW::Search qw( generic_option strip_tags );
use WWW::SearchResult;
use URI::Escape;

use strict;

# private
sub native_setup_search
  {
  my ($self, $native_query, $native_options_ref) = @_;

  $self->{_debug} = $native_options_ref->{'search_debug'};
  $self->{_debug} = 2 if ($native_options_ref->{'search_parse_debug'});
  $self->{_debug} ||= 0;

  # Why waste time sending so many queries?  Do a whole lot all at once!
  # 500 results take  70 seconds at 100 per page
  # 500 results take 234 seconds at  10 per page
  my $DEFAULT_HITS_PER_PAGE = 100;
  # $DEFAULT_HITS_PER_PAGE = 10 if $self->{_debug};
  $self->{'_hits_per_page'} = $DEFAULT_HITS_PER_PAGE;
  # $self->timeout(120);  # HotBot used to be notoriously slow

  $self->user_agent(0);
  # hotbot.pm seems to send a DIFFERENT page format if the client is
  # MSIE.  So, make sure they DON'T think we're MSIE!  Added by Martin
  # Thurn 2001-07-19.
  $self->{'agent_name'} = 'Mozilla/4.76';

  $self->{_next_to_retrieve} = 0;
  $self->{'_num_hits'} = 0;

  # Remove '*' at end of query terms within the user's query.  If the
  # query string is not escaped (even though it's supposed to be),
  # change '* ' to ' ' at end of words and at the end of the string.
  # If the query string is escaped, change '%2A+' to '+' at end of
  # words and delete '%2A' at the end of the string.
  $native_query =~ s/(\w)\052\s/$1\040/g;
  $native_query =~ s/(\w)\052$/$1\040/g;
  $native_query =~ s/(\w)\0452A\053/$1\053/g;
  $native_query =~ s/(\w)\0452A$/$1/g;
  if (!defined($self->{_options}))
    {
    $self->{_options} = {
                         'search_url' => 'http://hotbot.lycos.com/',
                         'matchmode' => 'any',
                         'query' => $native_query,
                         'recordcount' => $self->{_hits_per_page},
                         'descriptiontype' => 2,
                         'modsign0' => 'must',
                         'modtype0' => 'words',
                         'modwords0' => '',
                         'modsign1' => 'must',
                         'modtype1' => 'words',
                         'modwords1' => '',
                         'dateoption' => 'within',
                         'datedelta' => 0,
                         'daterelation' => 'newer',
                         'datemonth' => 1,
                         'DD' => 1,
                         dateyear => 2000,
                         language => 'any',
                         extension => '',
                         domain => '',
                         placeselection => 'georegion',
                         georegion => 'all',
                         sitegroup => 1,
                         pagetype => 'A',
                         PD => '',
                         'act.query' => 1,
                         search => 'SEARCH',
                         NUMMOD => 2,
                        };
    } # if
  my $options_ref = $self->{_options};
  if (defined($native_options_ref))
    {
    # Copy in new options.
    foreach (keys %$native_options_ref)
      {
      $options_ref->{$_} = $native_options_ref->{$_};
      } # foreach
    } # if

  # Finally, figure out the url.
  $self->{_next_url} = $self->{_options}{'search_url'} .'?'. $self->hash_to_cgi_string($options_ref);
  } # native_setup_search


sub gui_query
  {
  my ($self, $sQuery, $rh) = @_;
  $self->{'_options'} = {
                         'search_url' => 'http://hotbot.lycos.com/',
                         'MT' => $sQuery,
                         'SQ' => 1,
                         'TR' => 1,
                         'AM1' => 'MC',
                        };
  return $self->native_query($sQuery, $rh);
  } # gui_query


sub parse_tree
  {
  my $self = shift;
  my $oTree = shift;
  my $hits_found = 0;
  my @aoFONT = $oTree->look_down('_tag', 'font');
 FONT_TAG:
  foreach my $oBQ (@aoFONT)
    {
    if (ref $oBQ)
      {
      my $sBQ = $oBQ->as_text;
      print STDERR " +   BQ == $sBQ\n" if 2 <= $self->{_debug};
      if ($sBQ =~ m!(?:\A|\s)([0-9,]+)\s+Matches!i)
        {
        my $sCount = $1;
        # print STDERR " +     raw    count == $sCount\n" if 2 <= $self->{_debug};
        $sCount =~ s!,!!g;
        # print STDERR " +     cooked count == $sCount\n" if 2 <= $self->{_debug};
        $self->approximate_result_count($sCount);
        last FONT_TAG;
        } # if
      } # if
    } # foreach
  my @aoTD = $oTree->look_down('_tag', 'td');
 TD_TAG:
  foreach my $oTD (@aoTD)
    {
    next TD_TAG unless ref $oTD;
    print STDERR " +   try oTD ===", $oTD->as_text, "===\n" if 2 <= $self->{_debug};
    # See if this is the number of a result:
    next TD_TAG unless $oTD->as_text =~ m!\A\s*\d+\.(\s|\240|&nbsp;)*\Z!;
    my $oTDtitle = $oTD->right;
    # print STDERR " +   oTDtitle is ===$oTDtitle===\n" if 2 <= $self->{_debug};
    next TD_TAG unless ref $oTDtitle;
    my $sTitle = $oTDtitle->as_text;
    print STDERR " +   found title ===$sTitle===\n" if 2 <= $self->{_debug};
    my $oTRmom = $oTD->parent;
    next TD_TAG unless ref $oTRmom;
    # print STDERR " +   TRmom is ===", $oTRmom->as_HTML, "===\n" if 2 <= $self->{_debug};
    my $oTRrest = $oTRmom->right;
    next TD_TAG unless ref $oTRrest;
    print STDERR " +   TRrest is ===", $oTRrest->as_HTML, "===\n" if 2 <= $self->{_debug};
    my @aoFONT = $oTRrest->look_down('_tag', 'font');
    my $oFONT = shift @aoFONT;
    next TD_TAG unless ref $oFONT;
    print STDERR " +   description is in ===", $oFONT->as_HTML, "===\n" if 2 <= $self->{_debug};
    my $sDesc = $oFONT->as_text;
    $oFONT = shift @aoFONT;
    next TD_TAG unless ref $oFONT;
    print STDERR " +   URL is in ===", $oFONT->as_HTML, "===\n" if 2 <= $self->{_debug};
    my $oI = $oFONT->look_down('_tag', 'i');
    my $sDate = '';
    if (ref $oI)
      {
      $sDate = $oI->as_text;
      $oI->detach;
      $oI->delete;
      } # if
    my $sURL = $oFONT->as_text;
    my $hit = new WWW::SearchResult;
    $hit->add_url($sURL);
    $hit->title($sTitle);
    $hit->description(&WWW::Search::strip_tags($sDesc));
    $hit->change_date($sDate);
    push(@{$self->{cache}}, $hit);
    $self->{'_num_hits'}++;
    $hits_found++;
    } # foreach $oB
  my @aoA = $oTree->look_down('_tag', 'a');
  # Find the next link, if any:
 A_TAG:
  foreach my $oA (@aoA)
    {
    next unless ref $oA;
    if ($oA->as_text eq 'next')
      {
      $self->{_next_url} = $HTTP::URI_CLASS->new_abs($oA->attr('href'), $self->{'_prev_url'});
      last A_TAG;
      } # if
    } # foreach

 SKIP_NEXT_LINK:

  return $hits_found;
  } # parse_tree

1;

__END__

2000-10 text-only advanced search results:

http://hotbot.lycos.com/text/default.asp?matchmode=any&query=Martin+Thurn&recordcount=100&descriptiontype=2&modsign0=must&modtype0=words&modwords0=&modsign1=must&modtype1=words&modwords1=&dateoption=within&datedelta=0&daterelation=newer&datemonth=1&DD=1&dateyear=2000&language=any&extension=&domain=&placeselection=georegion&georegion=all&sitegroup=1&pagetype=A&PD=&act.query=1&search=SEARCH&NUMMOD=2

http://hotbot.lycos.com/text/default.asp?DD=1&NUMMOD=2&PD=&act.query=1&datedelta=0&datemonth=1&dateoption=within&daterelation=newer&dateyear=2000&descriptiontype=2&domain=&extension=&georegion=all&language=any&matchmode=any&modsign0=must&modsign1=must&modtype0=words&modtype1=words&modwords0=&modwords1=&pagetype=A&placeselection=georegion&query=Martin+Thurn&recordcount=100&search=SEARCH&sitegroup=1

2000-10 graphics-version advanced search results:

http://hotbot.lycos.com/?query=martin+thurn&cobrand=&act.query=1&matchmode=any&language=any&modsign0=must&modtype0=words&modwords0=&modsign1=must&modtype1=words&modwords1=&NUMMOD=2&dateoption=within&datedelta=0&daterelation=newer&datemonth=1&DD=1&dateyear=2000&extension=&placeselection=georegion&georegion=all&domain=&pagetype=A&PD=&recordcount=10&descriptiontype=2&SUBMIT=SEARCH

Martin''s page download results, 1998-02:

simplest arbitrary page:
http://www.search.hotbot.com/hResult.html?MT=lsam+replication&DE=0&DC=100
http://www.search.hotbot.com/hResult.html?MT=Christie+Abbott&base=100&DC=100&DE=0&act.next.x=1

text-only pages:
http://www.hotbot.com/text/default.asp?SM=MC&MT=Martin+Thurn&DC=100&DE=2&DV=0&RG=all&LG=any&_v=2&OPs=MDRTP&NUMMOD=2

explanation of known fields on GUI search page:
date = (checkbox) filter by date
     within = restrict to within DV days before today
     range = anchor date filter according to the date given in DR
DV = (selection) date (age) criteria
     0 = no date restriction
     <integer x> = restrict to within x days before today
DR = (selection) date anchor criteria
     older = only return pages updated before the date given in DY,DM,DD
     newer = only return pages updated after the date given in DY,DM,DD
DY = two-digit year (1998 = 98)
DM = month (January = 1)
DD = day of month
DC = (entry) number of hits per page
DE = (selection) output format
     0 = "URL only" (also gives title and score)
     1 = brief descriptions (adds description)
     2 = full descriptions (adds date and size)
FAX = (checkbox) only return pages that contain ActiveX data type
FJA = (checkbox) only return pages that contain Java data type
FJS = (checkbox) only return pages that contain JavaScript data type
FRA = (checkbox) only return pages that contain audio data type
FSU = (checkbox) only return pages whose name ends with extension(s) given in FS
FS = (text) file extensions for user-defined page-type selection (space-delimited)
FSW = (checkbox) only return pages that contain ShockWave data type
FVI = (checkbox) only return pages that contain image data type
FVR = (checkbox) only return pages that contain VRML data type
FVV = (checkbox) only return pages that contain video data type
MT = query terms
PS = (selection) depth of return page location on its website
     A = any page on site
     D = returned pages must be within PD (below) links of the top
     F = returned pages must be "top" page of website
     HP = personal pages (not implemented)
D = (integer) page depth for PS=D
RD = (checkbox) filter by location
     AN = return pages from anywhere
     DM = return pages whose URL ends with string given in Domain (below)
     RG = filter according to value of RG
Domain = (text) URL endings for user-defined location selection (space-delimited)
     for example "microsoft.com" ".cz"
RG = (selection) location criteria
     .com = North America (.com)
     .net = North America (.net)
     .edu = North America (.edu)
     .org = North America (.org)
     .gov = North America (.gov)
     .mil = North America (.mil)
     NA = North America (all)
     EU = Europe
     SE = Southeast Asia
     AS = India & Asia
     SA = South America
     DU = Oceania
     AF = Africa
     ME = Middle East
     CA = Central America
SM = (selection) search type 
     MC = all the words
     SC = any of the words
     phrase = exact phrase
     title = the page title
     name = the person
     url = links to this URL
     B = Boolean phrase
