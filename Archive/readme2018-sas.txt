
                                USING SAS WITH NAMCS DATA
   
  There are two ways to read the 2018 NAMCS public use data file using SAS:

  Option 1 - Use the zipped file namcs2018-sas.zip in the SAS folder on 
  the FTP server to open a complete SAS dataset of the 2018 NAMCS public use file.

  The steps for this option are as follows:

  1) Create a new folder on your local workstation, if desired, to house the file,
     for example, C:\MyFiles\NAMCS2018.

  2) Click on the file name namcs2018_sas.zip from the FTP server: 
     ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Datasets/NAMCS/
     and follow the prompts to save the file to your desired location.

  3) namcs2018_sas.zip is a compressed file which you must unzip prior to use. 
     In order to do this, double click on the file name in your directory screen; 
     an option to unzip the file should appear. Once you have selected the unzip option, 
     a new unzipped file called namcs2018_sas.sas7bdat should appear. This is the SAS 
     dataset. You can then move the file to your preferred location.

     Alternately, you can right-click on the name of the compressed file from your directory screen. 
     On the pop-up menu, there should be an option to extract the file to a location of your choosing.

     nam18for.txt is the file containing the formats which you will need to include in your
     program in order for the SAS file to run. This can be downloaded from 
     ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/dataset_documentation/namcs/sas.

  4) To use the SAS dataset, the following code provides an example for a file saved to c:\MyFiles\NAMCS2018:

     %inc "C:\MyFiles\NAMCS2018\nam18for.txt";  /*read in the SAS formats*/ 
     libname out1 'c:\MyFiles\NAMCS2018';  /*point to file location on your workstation*/
     data test18; set out1.namcs2018_sas;  /*create a temporary working file copied from the unzipped file*/
     proc surveyfreq data=test18;
     tables sex*ager /clwt cl;
     cluster cpsum;
     strata cstratm;
     weight patwt;
     run;

  Option 2 - Use the SAS input, label and format files provided to create your own SAS data set. 

  The steps for this option are as follows:

  1) Create a new folder on your local workstation, if desired, to house the file,
     for example, C:\MyFiles\NAMCS2018.

  2) Download to the new folder (or other desired location) the 2018 NAMCS ASCII dataset 
     (namcs2018.zip) from the FTP server: 
     ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Datasets/NAMCS/

     To do this, click on the file name and follow the prompts to save the file to your 
     desired location.

  3) namcs2018.zip is a compressed file which must be unzipped prior to use.
     In order to do this, double click on the file name in your directory screen; 
     an option to unzip the file should appear. Once you select the unzip option, a new file 
     called namcs2018 should appear.  This is the unzipped NAMCS ASCII dataset and has no file 
     extension.  

     Alternately, you can right-click on the name of the compressed file from your directory screen. 
     On the pop-up menu, there should be an option to extract the file to a location of your choosing.

  4) Download to the new folder the nam18inp.txt, nam18lab.txt and nam18for.txt files from the FTP server:
     ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/dataset_documentation/namcs/sas

  5) Sample SAS code is shown below; other examples can be found here: 
     https://www.cdc.gov/nchs/ahcd/ahcd_presentations.htm

     filename nam18pub "C:\MyFiles\NAMCS2018\namcs2018";        /*unzipped ASCII data set*/
     filename nam18for "C:\MyFiles\NAMCS2018\nam18for.txt";     /*SAS format statement*/
     filename nam18inp "C:\MyFiles\NAMCS2018\nam18inp.txt";     /*SAS input statement*/
     filename nam18lab "C:\MyFiles\NAMCS2018\nam18lab.txt";     /*SAS label statement*/

     %inc nam18for;  /*reads in the formats*/

     data test18; 
     infile nam18pub missover lrecl=9999;
     %inc nam18inp;  /*reads in the input statement*/
     %inc nam18lab;  /*reads in the labels*/
     run;

     proc surveyfreq data=test18;
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
