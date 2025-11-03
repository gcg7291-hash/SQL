package a.basic;

public class Operator {
    public static void main(String[] args){
        int a = 10;
        int b = 20;

        System.out.println(a + b);
        System.out.println(a % b);

        int x = 10;
        int y = 3;
        System.out.println(x / y);

        double result = (double)x / y;
        System.out.println(result);

        // ++x, --x -> 증감 이후에 출력, x++, x-- -> 출력 이후에 증감
        System.out.println("x= "+ --x);
        System.out.println("x= " + x);

        // x += 5 -> x = x + 5
        x += 5;
        System.out.println("x += 5 =>" + x);

        int bigNum = 999;
        int smallNum = 1;

        System.out.println(bigNum > smallNum);

        String strA = "hello";
        String strB = "hello";
        String strC = new String("hello");


        System.out.println("strA == strB =>" + (strA == strB));
        System.out.println("strA == strC =>" + (strA == strC));

        System.out.println(strA.equals(strC));

        boolean boolA = true;
        boolean boolB = false;

        System.out.println(boolA == boolB);

        // 단락평가
        int myX = 0;
        // 10 / 0 => 모든 수는 0 으로 나눌수 없음
        if (myX != 0 && 10 / x > 1) {
            System.out.println("실행되나요??");
        }

        // 삼항연산자
        int age = 30;
        String adult = (age > 20) ? "성인" : "청소년";
        System.out.println(adult);

        //  1010 => 10
        // 8421 2진수 읽는법

        int intA = 14;
        int intB = 6;
        System.out.println(intA & intB);

        int intC = 123456;
        int intP = -123;
        System.out.println(intC << 1); // 2배
        System.out.println(intC >> 1); // 1/2
        System.out.println(intP >>> 1);

    }
}
