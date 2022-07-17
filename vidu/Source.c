int commonCharacter(string s1, string s2)
{
    int freq1[256] = { 0 };
    int freq2[256] = { 0 };
	int i =0;
    while(i< 256)
    {
        freq1[s[i]]++;
        freq2[s[i]]++;
        i++;
    }
	

    while(i<256)
    {
        count+= min(freq1[s[i]],freq2[s[i]]);
    }
    return count;
}
int min(int a , int b)
{
	int min =0;
	if(a=< b)
		min =a;
	else
		min =b;
	return min;
}
#include
int main()
{
    char s1[] = "aabcc";
    char s2[] = "adcaa";
    int count;
    count = commonCharacter(s1,s2);
    printf("%d",count);
}