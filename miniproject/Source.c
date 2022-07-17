
#include<stdio.h>
#include<string.h>
int main()
{   
    char s1[] = "aabcc";
    char s2[] = "adcaa";
    int count=0;
    count = commonCharacterCount(s1,s2);
    printf("\nSo ki tu chung :%d\n",count);
}
int min(int a , int b)
{
	int min =0;
	if(a <= b)
		min = a;
	else
		min = b;
	return min;
}
int commonCharacterCount(char s1[] , char s2[])
{
    int freq1[26],freq2[26],char_freq[26],i,count = 0;
    for(i = 0;i<26;i++)
    {
        freq1[i] = 0;
        freq2[i] = 0;
        char_freq[i] =0;
    }
    for(i =0; i< strlen(s1); i++)
    {
        freq1[s1[i]- 'a']++;
    }
    for(i =0; i< strlen(s2); i++)
    {
        freq2[s2[i]-'a']++;
    }
    for(i=0;i<26;i++)  
    {
        char_freq[i] = min(freq1[i],freq2[i]);
        count+= min(freq1[i],freq2[i]);
        
    }
    for(i=0;i<26;i++)
    {
        if(char_freq[i] > 0)
        printf("%d  '%c'\n",char_freq[i] ,i +'a');
    }
    return count;
}
