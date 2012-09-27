unihan_extractor
================

Extracts selected character data from the publicly available Unicode Han Database (unihan).
Database available on: http://www.unicode.org/reports/tr38/

★Input files
  input/Unihan_DictionaryLikeData.txt
  input/Unihan_Readings.txt
  input/Unihan_Variants.txt
  input/Unihan_OtherMappings.txt
  input/Unihan_RadicalStrokeCounts.txt
  input/Unihan_NumericValues.txt
  input/Unihan_IRGSources.txt
  input/Unihan_DictionaryIndices.txt

★What this does
  Each of those files include several unicode properties (see lines 12 to 23 in each file)
  This perl script extracts the selected data and creates a new string file

Example extract on 2 files: Unihan_DictionaryLikeData.txt and Unihan_Readings.txt
Unihan_DictionaryLikeData.txt
    Unicode    - Unicode input string encoding number
    kFrequency - Frequency (if it does not exist, value will be 0 )
    kCangjie   - Cangjie input use

Unihan_Readings.txt
    Unicode      - Unicode input string encoding number
    kHanyuPinyin - PinYin
    kCantonese   - Cantonese PinYin

★Output
  Makes a new string in another file similar to the following:
  
  Unicode kFrequency kCangjie kHanyuPinyin kCantonese

* Each item is divided with a TAB
* If there is no item found, it is left as an empty string
* For each unicode, if there are multiple PinYin, they are joined by a comma ","



★Example of what data will look like for the following after extraction:

●input/Unihan_DictionaryLikeData.txt  
U+3636	kCangjie	NQG  
U+3636	kTotalStrokes	9  
U+3637	kCangjie	GTK  
U+3637	kTotalStrokes	9  
U+3638	kCangjie	MNPG  
U+3638	kTotalStrokes	9  

●input/Unihan_Readings.txt  
U+3636	kCantonese	git6 miu5  
U+3636	kDefinition	(ancient form of 桀) a hen-roost, cruel, the last ruler of the Xia Dynasty  
U+3636	kMandarin	jié  
U+3637	kCantonese	ngai6  
U+3637	kDefinition	(same as 艾) Mugwort, artemisia or any plant which produces moxa punk, general name for plants like mint  
U+3637	kMandarin	ài  
U+3638	kCantonese	zong3  
U+3638	kDefinition	(same as 葬) to bury, (ancient form of 坐) to sit, a seat  
U+3638	kHanyuPinyin	10438.060:zàng,zuò  
U+3638	kMandarin	zàng  


●Output would be:

U+3636	0	NQG		git6,miu5  
U+3637	0	GTK		ngai6  
U+3638	0	MNPG	zàng,zuò	zong3  
