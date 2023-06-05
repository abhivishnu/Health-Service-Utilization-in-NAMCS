
        USING SAS WITH NATIONAL AMBULATORY MEDICAL CARE SURVEY (NAMCS) COMMUNITY HEALTH CENTER (CHC) DATA
   
  There are two ways to read the 2015 NAMCS Community Health Center public use data file using SAS:

  Option 1 - Use the zipped file namcs2015_chc.zip in the SAS folder on 
  the FTP server to open a complete SAS dataset of the 2015 NAMCS CHC public use file.

  The steps for this option are as follows:

  1) Create a new folder on your local workstation, for example, C:\MyFiles\CHC2015

  2) Download to the new folder the file namcs2015_chc-sas.zip from the FTP server: 
     https://ftp.cdc.gov/pub/Health_Statistics/NCHS/dataset_documentation/namcs/sas

  3) namcs2015_chc-sas.zip is a compressed file which you must unzip prior to use. 
     In order to do this, double click on the file name in your directory screen; 
     an option to unzip the file should appear. Specify the desired location to unzip
     the file to and click on the Unzip option.  A new unzipped file should then appear, 
     called namcs2015_chc-sas.sas7bdat. This is the SAS dataset. You can then move the 
     file to your preferred location.

     Alternately, you can right-click on the name of the compressed file from your directory screen. 
     On the pop-up menu, there should be an option to extract the file to a location of your choosing.

  4) To use the SAS dataset, the following code provides an example for a file saved to C:\MyFiles\CHC2015:

     %inc "C:\MyFiles\CHC2015\chc15for.txt";   /*read in the SAS formats*/
     libname out1 'C:\MyFiles\CHC2015';        /*point to file location on your workstation*/
     data test15; set out1.namcs2015_chc-sas;  /*create a temporary working file copied from the unzipped file*/
     proc surveyfreq data=test15;
     tables sex*ager /clwt cl;
     cluster cpsum;
     strata cstratm;
     weight patwt;
     run;
 
  Option 2 - Use the SAS input, label and format files provided to create your own SAS data set. 

  The steps for this option are as follows:

  1) Create a new folder on your local workstation, for example, C:\MyFiles\CHC2015

  2) Download to the new folder the 2015 NAMCS CHC dataset (namcs2015_chc.zip) from the FTP server: 
     https://ftp.cdc.gov/pub/Health_Statistics/NCHS/datasets/namcs

  3) namcs2015_chc.zip is a compressed file which must be unzipped prior to use.
     In order to do this, double click on the file name in your directory screen; 
     an option to unzip the file should appear. Specify the desired location to unzip
     the file to and click on the Unzip option.  A new unzipped file should then appear,  
     called namcs2015_chc with no extension. This is the NAMCS CHC ASCII dataset. You can then 
     move the file to your preferred location. 

  4) Download to the new folder the chc15inp.txt, chc15lab.txt and chc15for.txt files from the FTP server:
     https://ftp.cdc.gov/pub/Health_Statistics/NCHS/dataset_documentation/namcs/sas

  5) Sample SAS code is shown below; other examples can be found here: 
     https://www.cdc.gov/nchs/ahcd/ahcd_presentations.htm

     filename chc15pub "C:\MyFiles\CHC2015\namcs2015_chc";         /*unzipped ASCII data set*/
     filename chc15for "C:\MyFiles\CHC2015\chc15for.txt";          /*SAS format statement*/
     filename chc15inp "C:\MyFiles\CHC2015\chc15inp.txt";          /*SAS input statement*/
     filename chc15lab "C:\MyFiles\CHC2015\chc15lab.txt";          /*SAS label statement*/

     %inc chc15for;  /*reads in the formats*/

     data test15; 
     infile chc15pub missover lrecl=9999;
     %inc chc15inp;  /*reads in the input statement*/
     %inc chc15lab;  /*reads in the labels*/
     run;

     proc surveyfreq data=test15;
     tables sex*ager /clwt cl;
     cluster cpsum;
     strata cstratm;
     weight patwt;
     run;


   CAUTION - Because NAMCS is a sample survey, the application of 
   weights to the sample data is REQUIRED to produce national estimates
   of office visits, as well as to accurately assess the sampling error of
   statistics based on the survey data.  Please refer to the appropriate
   sections of the documentation file for information on how to apply the 
   weights and to obtain relative standard errors of national estimates.
                                                                                                
   For questions, suggestions, or comments concerning NAMCS data, please
   contact the Ambulatory and Hospital Care Statistics Branch at 
   (301) 458-4600 or by email at ambcare@cdc.gov. 

   For additional information on NCHS data products, please call CDC-INFO at 
   800-CDC-INFO (800-232-4636), TTY (888-232-6348), Monday-Friday 8am-8pm EST, 
   or use the CDC-INFO online request form at https://www.cdc.gov/info.
