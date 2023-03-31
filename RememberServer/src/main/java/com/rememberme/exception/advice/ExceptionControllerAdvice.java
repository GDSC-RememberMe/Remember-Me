package com.rememberme.exception.advice;

import com.rememberme.exception.ErrorResult;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice(annotations = RestController.class) // 모든 RestController에 적용, 일종의 AOP
public class ExceptionControllerAdvice {

    // IllegalArgumentException 발생 시, 이 로직이 호출
    // 기본적으로는 정상 흐름 처리됨(상태코드 200)
    // 따라서 에러 코드를 반환하려면 ResponseEntity에 HttpStatus 상태코드 함께 전달
    @ApiOperation(value = "입력값 중복 예외")
    @ExceptionHandler
    public ResponseEntity<ErrorResult> illegalExceptionHandler (IllegalArgumentException e) {
        log.error("ExceptionHandler : ", e);
        ErrorResult errorResult = new ErrorResult(400, e.getMessage());
        return new ResponseEntity<>(errorResult, HttpStatus.BAD_REQUEST);
    }

    @ApiOperation(value = "입력 형식 예외")
    @ExceptionHandler
    public ResponseEntity<ErrorResult> validExceptionHandler (MethodArgumentNotValidException e) {
        log.error("ExceptionHandler : ", e);

        // @Vaild 어노테이션에서 설정한 message만 보기 위해서
        BindingResult bindingResult = e.getBindingResult();
        StringBuilder stringBuilder = new StringBuilder();
        for (FieldError fieldError : bindingResult.getFieldErrors()) {
            stringBuilder.append(fieldError.getDefaultMessage());
        }

        ErrorResult errorResult = new ErrorResult(400, stringBuilder.toString());
        return new ResponseEntity<>(errorResult, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ApiOperation(value = "최상위 예외 처리")
    @ExceptionHandler
    public ResponseEntity<ErrorResult> exceptionHandler (Exception e) {
        log.error("ExceptionHandler : ", e);
        ErrorResult errorResult = new ErrorResult(500, e.getMessage());
        return new ResponseEntity<>(errorResult, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}