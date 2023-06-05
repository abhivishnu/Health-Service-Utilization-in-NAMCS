
                         2016 National Ambulatory Medical Care Survey Supplement on 
                Culturally and Linguistically Appropriate Services for Office-based Physicians 
                                   (National CLAS Physician Survey)

                                      Instructions for Using SAS

  There are two ways to read the 2016 NAMCS CLAS Physician Survey public use data file using SAS:

  Option 1 - Use the file namcs_clas2016_sas.zip in the SAS folder on 
  the FTP server to open a complete SAS dataset of the 2016 NAMCS CLAS public use file.

  The steps for this option are as follows:

  1) Create a new folder on your local workstation, for example, C:\MYFILES\CLAS2016

  2) Download to the new folder the file namcs_clas2016_sas.zip from the FTP server: 
     ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/dataset_documentation/namcs/sas

  3) namcs_clas2016_sas.zip is a compressed file which you must unzip prior to use. 
     In order to do this, double click on the file name in your directory screen; 
     an option to unzip the file should appear. A new folder, namcs_clas2016_sas, will probably 
     be created, depending on the software your system uses. The unzipped file 
     namcs_clas2016_sas.sas7bdat will be within that folder. This is the SAS dataset. 
     You can then move the file to your preferred location.

     Alternately, you can right-click on the name of the compressed file from your directory screen. 
     On the pop-up menu, there should be an option to extract the file to a location of your choosing.

  4) To use the SAS dataset, the following code provides an example for a file saved to C:\MyFiles\CLAS2016:

     libname out1 'C:\MyFiles\CLAS2016';  /*point to file location on your workstation*/
     data test16; set out1.namcs_clas2016_sas;  /*create a temporary working file copied from the unzipped file*/
     proc surveyfreq data=test16;
     strata cstratm;
     weight clasweight;
     tables region /clwt cl;
     run;
 
  Option 2 - Use the SAS input, label and format files provided to create your own SAS data set. 

  The steps for this option are as follows:

  1) Create a new folder on your local workstation, for example, C:\MYFILES\CLAS2016

  2) Download to the new folder the 2016 NAMCS CLAS dataset (namcs_clas2016) from the FTP server: 
     ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/datasets/namcs

     namcs_clas2016 is in ASCII format.  It is not compressed and therefore does not have to be unzipped prior to use.

  3) Download to the new folder the cls16inp.txt, cls16lab.txt and cls16for.txt files 
     from the FTP server:
     ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/dataset_documentation/namcs/sas

  4) Sample SAS code is shown below:

     filename cls16pub "C:\MyFiles\CLAS2016\namcs_clas2016";   /*ASCII data set*/
     filename cls16for "C:\MyFiles\CLAS2016\cls16for.txt";     /*SAS format statement*/
     filename cls16inp "C:\MyFiles\CLAS2016\cls16inp.txt";     /*SAS input statement*/
     filename cls16lab "C:\MyFiles\CLAS2016\cls16lab.txt";     /*SAS label statement*/

     %inc cls16for;  /*reads in the formats*/

     data test16; 
     infile cls16pub missover lrecl=9999; /*reads in data file*/
     %inc cls16inp;  /*reads in the input statement*/
     %inc cls16lab;  /*reads in the labels*/
     run;

     proc surveyfreq data=test16;
     strata cstratm;
     weight clasweight;
     tables region /clwt cl;
     run;

   CAUTION - Because NAMCS CLAS is a sample survey, the application of 
   weights to the sample data is REQUIRED to produce national estimates
   of physicians, as well as to accurately assess the sampling error of
   statistics based on the survey data.  Please refer to the appropriate
   sections of the documentation file for information on how to apply the 
   weights and to obtain relative standard errors of national estimates.
                                                                                                
   For questions, suggestions, or comments concerning NAMCS CLAS data, please
   contact the Ambulatory and Hospital Care Statistics Branch at 
   (301) 458-4600 or by email at ambcare@cdc.gov. 

   For additional information on NCHS data products, please call CDC-INFO at 
   800-CDC-INFO (800-232-4636), TTY (888-232-6348), Monday-Friday 8am-8pm EST, 
   or use the CDC-INFO online request form at https://www.cdc.gov/info.
   NCHS website: http://www.cdc.gov/nchs/