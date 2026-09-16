# Spring Boot 실습 학습 정리

## 1. URL 단축 방식

URL 단축 서비스에서는 긴 URL을 짧은 경로로 바꿔서 사용한다.

예를 들어 원래 URL이 아주 길다면, 서버에서 특정 ID를 부여한 뒤 아래처럼 짧은 주소로 접근할 수 있게 만들 수 있다.

```text
http://localhost:8080/g/2
http://localhost:8080/s/2
```

여기서 `g`, `s` 같은 문자는 컨트롤러에서 정한 경로이다.

```java
@GetMapping("/g/{id}")
@ResponseBody
public String go(@PathVariable long id) {
    return "id = " + id;
}
```

위 코드에서 `/g/{id}`는 브라우저 주소의 값을 메서드로 전달한다.

```text
http://localhost:8080/g/2
```

이렇게 접속하면 `id` 값으로 `2`가 들어간다.

## 2. Spring Boot는 웹 서버 역할을 한다

Spring Boot는 웹 서버로 동작할 수 있다.

클라이언트는 브라우저, Postman, 프론트엔드 앱 등이 될 수 있고, 서버에 URL로 요청을 보낸다.

예를 들어 브라우저에서 아래 주소로 접속하면,

```text
http://localhost:8080/todos
```

Spring Boot 서버가 요청을 받아서 해당 URL에 연결된 메서드를 실행하고 결과를 응답한다.

즉, Spring Boot는 클라이언트가 원격으로 접속할 수 있는 웹 서버 역할을 한다.

## 3. `@GetMapping`은 URL과 메서드를 연결한다

`@GetMapping`은 브라우저에서 들어오는 `GET` 요청을 특정 메서드와 연결하는 어노테이션이다.

```java
@GetMapping("/a")
@ResponseBody
public String hello() {
    return "Hello";
}
```

위 코드가 있으면 브라우저에서 아래 주소로 접속할 수 있다.

```text
http://localhost:8080/a
```

즉, `@GetMapping`이 붙은 메서드는 브라우저 요청으로 호출 가능한 액션 메서드가 된다.

## 4. `@ResponseBody`는 리턴 값을 브라우저에 보여준다

일반적인 `@Controller`에서 문자열을 리턴하면 Spring은 보통 뷰 이름으로 해석한다.

하지만 `@ResponseBody`를 붙이면 리턴 값을 그대로 응답 본문에 담아 브라우저에 출력한다.

```java
@Controller
public class HomeController {

    @GetMapping("/a")
    @ResponseBody
    public String hello() {
        return "Hello Spring Boot";
    }
}
```

브라우저에서 접속하면 화면에 아래 문자가 그대로 보인다.

```text
Hello Spring Boot
```

참고로 `@RestController`를 사용하면 클래스 전체에 `@ResponseBody`가 적용된 것처럼 동작한다.

## 5. URL의 `?` 뒤에 값을 넣으면 메서드 변수로 전달된다

URL에서 `?` 뒤에 붙는 값들을 쿼리 파라미터라고 한다.

예를 들어 아래처럼 접속하면,

```text
http://localhost:8080/a?id=3&age=20
```

컨트롤러 메서드에서 `id`, `age` 값을 받을 수 있다.

```java
@GetMapping("/a")
@ResponseBody
public String hello(String id, String age) {
    return "%s번 사람의 나이는 %s살입니다.".formatted(id, age);
}
```

결과는 아래처럼 나온다.

```text
3번 사람의 나이는 20살입니다.
```

다만 사용자가 URL에 직접 값을 넣을 수 있기 때문에 서버에서는 항상 검증이 필요하다.

예를 들어 숫자만 받아야 하는 값은 `int`, `long` 같은 타입으로 받고, 필수값인지 확인하거나, 잘못된 값이 들어왔을 때 예외 처리를 해야 한다.

```java
@GetMapping("/plus")
@ResponseBody
public String plus(int a, int b) {
    return "결과 = " + (a + b);
}
```

보안 문제를 막기 위해 단순히 `const`를 쓰는 것이 아니라, 서버에서 입력값 검증, 권한 확인, 예외 처리 등을 해야 한다.

Java에서는 값이 바뀌면 안 되는 변수에 `final`을 사용할 수 있지만, 이것만으로 웹 보안이 해결되는 것은 아니다.

## 6. Spring Boot의 자동 형 변환과 Jackson

브라우저에서 들어오는 쿼리 파라미터는 기본적으로 문자열이다.

하지만 Spring Boot는 메서드 파라미터 타입에 맞게 자동으로 형 변환을 해준다.

예를 들어 URL은 문자열로 들어오지만,

```text
http://localhost:8080/plus?a=10&b=20
```

컨트롤러에서 `int`로 받을 수 있다.

```java
@GetMapping("/plus")
@ResponseBody
public String plus(int a, int b) {
    return "a + b = " + (a + b);
}
```

Spring이 `"10"`, `"20"`이라는 문자열을 `int` 타입으로 변환해준다.

또한 객체를 리턴하면 Jackson이 객체를 JSON 형태로 변환해준다.

```java
@GetMapping("/todo")
@ResponseBody
public Todo todo() {
    return Todo.builder()
            .id(1L)
            .body("공부하기")
            .build();
}
```

브라우저 응답 예시는 아래와 같다.

```json
{
  "id": 1,
  "body": "공부하기"
}
```

정리하면, 쿼리 파라미터의 기본 형 변환은 Spring MVC가 처리하고, 객체를 JSON으로 바꾸는 작업은 Jackson이 처리한다.
