package a.basic;

public class ifStatement {
    public static void main(String[] args){
        // 기본 if 문
        int age1 = 20;
        if (age1 >= 20) {
            System.out.println("성인 입니다.");
        }

        // if ~else, if ~else
        int score = 80;

        if (score >= 90) {
            System.out.println("A");
        } else  if (score >= 80) {
            System.out.println("B");
        } else  if (score >= 70) {
            System.out.println("C");
        } else {
            System.out.println("재수강");
        }

        // 중첩 if 문
        int age = 25;
        boolean hasLicense = true;

        if (age >= 18) {
            if (hasLicense) {
                System.out.println("운전 가능");
            } else {
                System.out.println("면허 필요");
            }
        } else {
            System.out.println("나이 미달");
        }

        // 논리 연산자로 간단하게
        if (age >= 18 && hasLicense) {
            System.out.println("운전 가능");
        }

        int month = 11;

        String season = switch (month) {
            case 3, 4, 5 -> "봄";
            case 6, 7, 8 -> "여름";
            case 9, 10, 11 -> "가을";
            case 12 , 1, 2 -> "겨울";
            default -> "잘못된 월";
        };
        System.out.println(season);
    }
}
