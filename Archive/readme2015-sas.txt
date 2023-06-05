                                  USING SAS
    
  There are two ways to read the 2015 NAMCS public use data file using SAS:

  Option 1 - Use the zipped file namcs2015_sas.zip in the SAS folder on 
  the FTP server to open a complete SAS dataset of the 2015 NAMCS public use file.

  The steps for this option are as follows:

  1) Create a new folder on your local workstation, for example, C:\MYFILES\NAMCS2015

  2) Download to the new folder the file namcs2015_sas.zip from the FTP server: 
     ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/dataset_documentation/namcs/sas

  3) namcs2015_sas.zip is a compressed file which you must unzip prior to use. 
     In order to do this, double click on the file name in your directory screen; 
     an option to unzip the file should appear. A new folder, namcs2015_sas, will probably 
     be created, depending on the software your system uses. The unzipped file 
     namcs2015_sas.sas7bdat 
     will be within that folder. This is the SAS dataset. You can then move the file to 
     your preferred location.

     Alternately, you can right-click on the name of the compressed file from your directory screen. 
     On the pop-up menu, there should be an option to extract the file to a location of your choosing.

  4) To use the SAS dataset, the following code provides an example for a file saved to C:\MyFiles\NAMCS2015:

     libname out1 'C:\MyFiles\NAMCS2015';  /*point to file location on your workstation*/
     data test15; set out1.namcs2015_sas;  /*create a temporary working file copied from the unzipped file*/
     proc surveyfreq data=test15;
     tables sex*ager /clwt cl;
     cluster cpsum;
     strata cstratm;
     weight patwt;
     run;
 
  Option 2 - Use the SAS input, label and format files provided to create your own SAS data set. 

  The steps for this option are as follows:

  1) Create a new folder on your local workstation, for example, C:\MYFILES\NAMCS2015

  2) Download to the new folder the 2015 NAMCS dataset (namcs2015.zip) from the FTP server: 
     ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/datasets/namcs

  3) namcs2015.zip is a compressed file which must be unzipped prior to use.
     In order to do this, double click on the file name in your directory screen; 
     an option to unzip the file should appear. A new folder, namcs2015, will probably 
     be created, depending on the software your system uses. The unzipped file namcs2015 
     with no extension will be within that folder. This is the NAMCS ASCII dataset. You can then 
     move the file to your preferred location. 

  4) Download to the new folder the nam15inp.txt, nam15lab.txt and nam15for.txt files from the FTP server:
     ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/dataset_documentation/namcs/sas

  5) Sample SAS code is shown below; other examples can be found here: 
     https://www.cdc.gov/nchs/ahcd/ahcd_presentations.htm

     filename nam15pub "C:\MyFiles\NAMCS2015\namcs2015";        /*unzipped ASCII data set*/
     filename nam15for "C:\MyFiles\NAMCS2015\nam15for.txt";     /*SAS format statement*/
     filename nam15inp "C:\MyFiles\NAMCS2015\nam15inp.txt";     /*SAS input statement*/
     filename nam15lab "C:\MyFiles\NAMCS2015\nam15lab.txt";     /*SAS label statement*/

     %inc nam15for;  /*reads in the formats*/

     data test15; 
     infile nam15pub missover lrecl=9999;
     %inc nam15inp;  /*reads in the input statement*/
     %inc nam15lab;  /*reads in the labels*/
     run;

     proc surveyfreq data=test15;
     tables sex*ager /clwt cl;
     cluster cpsum;
     strata cstratm;
     weight patwt;
     run;

   CAUTION - Because the NAMCS is a sample survey, the application of 
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
