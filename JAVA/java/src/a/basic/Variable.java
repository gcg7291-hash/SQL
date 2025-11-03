package a.basic;

public class Variable {
    public static void main(String[] args) {
        // 기본형 타입 java에는 8개의 기본형 타입이 있다.
        // 선언
        // 타입 변수명:
        int age;

        // 할당
        // 변수명 = 값;
        age = 20;

        System.out.printf("나이 %d", age);
        // 선언과 할당을 같이
        // 타입 변수명 = 값;
        String name = "Kim";
        System.out.printf("이름 %s", name);

        // 기본형 타입
        // 정수형 (byte, short, int ,long)
        byte b = 100;
        short s = 10000;
        int i = 1000000000;
        long l = 10000000000L;
        System.out.println();

        System.out.println(b);
        System.out.println(s);
        System.out.println(l);

        // 실수형 (float, double)
        float f = 3.14f;
        double d = 3.14;
        System.out.println(d);

        // 문자형 (char)
        char c = 'A';
        System.out.println(c);

        // 논리형 (boolean)
        boolean bool = true;
        System.out.println(bool);

        // 참조형 타입
        // String (문자열 타입)
        String str = "Hello";
        System.out.println(str);

        String str2 = "world";
        String msg = str + str2;
        System.out.println(msg);

        // null
        String str3 = null;

        // 형변환
        int iA = 100;
        double dA = iA;

        // 강제 타입 형변환
        double dB = 3.14;
        int iB = (int)dB;
        System.out.println(iB);

        // var
        var myData = 1000;
        var myData2 = "Hello";
        var myData3 = true;


    }
}
