Bigint longint in sas r and python                                                                                             
                                                                                                                               
github                                                                                                                         
https://tinyurl.com/y78pu45h                                                                                                   
https://github.com/rogerjdeangelis/utl-bigint-longint-in-sas-r-and-python                                                      
                                                                                                                               
Rather than spending time learning DS2, which does                                                                             
not support file I/O, spend you tme learning a little                                                                          
R or Python                                                                                                                    
                                                                                                                               
Problem: Sum integers whose toal is the largest positive integer in a signed 64bit word.                                       
The largest integer is                                                                                                         
                                                                                                                               
   %let x=9223372036854775807;                                                                                                 
                                                                                                                               
   Three solutions (if hardware longint is there why not use it?)                                                              
                                                                                                                               
       a. SAS macro (true C implemented lonint hardware processing?)                                                           
                                                                                                                               
       b  SAS datastep  code (simulation of longint)                                                                           
          http://tinyurl.com/y2wtmtdz                                                                                          
                                                                                                                               
       c. Python (has infinite integer support but not hardware implementation?)                                               
          I am not sure Python has hardware support for 64bit integers,                                                        
          may be slow because it simulates 64bit hardware.                                                                     
                                                                                                                               
                                                                                                                               
       d. R GMP (no native hardware support for 64bit integers, however there are several packages)                            
          https://goo.gl/g7RQew                                                                                                
          also package bit64 (fast?)                                                                                           
/*                   _                                                                                                         
(_)_ __  _ __  _   _| |_                                                                                                       
| | `_ \| `_ \| | | | __|                                                                                                      
| | | | | |_) | |_| | |_                                                                                                       
|_|_| |_| .__/ \__,_|\__|                                                                                                      
        |_|                                                                                                                    
  __ _   ___  __ _ ___   _ __ ___   __ _  ___ _ __ ___                                                                         
 / _` | / __|/ _` / __| | `_ ` _ \ / _` |/ __| `__/ _ \                                                                        
| (_| | \__ \ (_| \__ \ | | | | | | (_| | (__| | | (_) |                                                                       
 \__,_| |___/\__,_|___/ |_| |_| |_|\__,_|\___|_|  \___/                                                                        
                                                                                                                               
*/                                                                                                                             
                                                                                                                               
The maximum positive integer in signed 64bit word.                                                                             
                                                                                                                               
%let x=9223372036854775807;                                                                                                    
                                                                                                                               
* Here is a macro solution;                                                                                                    
%macro bigint;                                                                                                                 
                                                                                                                               
  %let x=9223372036854775800;                                                                                                  
  %put &=x;                                                                                                                    
                                                                                                                               
  %do i=1 %to 7;                                                                                                               
     %let x=%eval(&x+1);                                                                                                       
     %put &=x;                                                                                                                 
  %end;                                                                                                                        
                                                                                                                               
%mend bigint;                                                                                                                  
                                                                                                                               
%bigint;                                                                                                                       
                                                                                                                               
X=9223372036854775800                                                                                                          
X=9223372036854775801                                                                                                          
X=9223372036854775802                                                                                                          
X=9223372036854775803                                                                                                          
X=9223372036854775804                                                                                                          
X=9223372036854775805                                                                                                          
X=9223372036854775806                                                                                                          
X=9223372036854775807 ** BigInt;                                                                                               
                                                                                                                               
/*                            _       _            _                                                                           
| |__     ___  __ _ ___    __| | __ _| |_ __ _ ___| |_ ___ _ __                                                                
| `_ \   / __|/ _` / __|  / _` |/ _` | __/ _` / __| __/ _ \ `_ \                                                               
| |_) |  \__ \ (_| \__ \ | (_| | (_| | || (_| \__ \ ||  __/ |_) |                                                              
|_.__(_) |___/\__,_|___/  \__,_|\__,_|\__\__,_|___/\__\___| .__/                                                               
                                                          |_|                                                                  
*/                                                                                                                             
                                                                                                                               
http://tinyurl.com/y2wtmtdz                                                                                                    
                                                                                                                               
/*                    _   _                                                                                                    
  ___     _ __  _   _| |_| |__   ___  _ __                                                                                     
 / __|   | `_ \| | | | __| `_ \ / _ \| `_ \                                                                                    
| (__ _  | |_) | |_| | |_| | | | (_) | | | |                                                                                   
 \___(_) | .__/ \__, |\__|_| |_|\___/|_| |_|                                                                                   
         |_|    |___/                                                                                                          
*/                                                                                                                             
                                                                                                                               
/* open source communication with python and R is a pain - we need shared storage */                                           
/* no peek and poke between SAS and R/Python */                                                                                
                                                                                                                               
%symdel frompy / nowarn;                                                                                                       
                                                                                                                               
%let x=9223372036854775800;                                                                                                    
                                                                                                                               
%utl_submit_py64_38(resolve('                                                                                                  
import numpy as np;                                                                                                            
import io;                                                                                                                     
import pyperclip;                                                                                                              
sum = &x;                                                                                                                      
for i in range(7):;                                                                                                            
.     sum=sum+1;                                                                                                               
print(sum);                                                                                                                    
output = io.StringIO();                                                                                                        
print(sum,file=output,end="");                                                                                                 
output = output.getvalue();                                                                                                    
pyperclip.copy(output);                                                                                                        
output.close();                                                                                                                
'),return=fromPy);                                                                                                             
                                                                                                                               
%put &=frompy;                                                                                                                 
                                                                                                                               
FROMPY=9223372036854775807                                                                                                     
                                                                                                                               
/*   _                                                                                                                         
  __| |    _ __                                                                                                                
 / _` |   | `__|                                                                                                               
| (_| |_  | |                                                                                                                  
 \__,_(_) |_|                                                                                                                  
                                                                                                                               
*/                                                                                                                             
                                                                                                                               
https://tinyurl.com/yaljdbf7                                                                                                   
https://github.com/rogerjdeangelis/utl_near_infinite_precision_arithmetic_r_package_gmp                                        
                                                                                                                               
%symdel x / nowarn;                                                                                                            
                                                                                                                               
%utlnopts;                                                                                                                     
%macro sumbigint();                                                                                                            
  %do i=1 %to 7;                                                                                                               
     %let x=%eval(&x+1);                                                                                                       
     %put ## &=x ##;                                                                                                           
  %end;                                                                                                                        
%mend sumbigint;                                                                                                               
                                                                                                                               
data want;                                                                                                                     
                                                                                                                               
  x='9223372036854775800';                                                                                                     
  call symputx('x',x);                                                                                                         
                                                                                                                               
  rc=dosubl('%sumbigint();');                                                                                                  
                                                                                                                               
  sumx=symget('x');                                                                                                            
                                                                                                                               
  put sumx= $32.;                                                                                                              
                                                                                                                               
run;quit;                                                                                                                      
                                                                                                                               
                                                                                                                               
