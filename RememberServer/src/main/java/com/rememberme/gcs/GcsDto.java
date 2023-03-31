package com.rememberme.gcs;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GcsDto {

    private String fileName;

    private String fileUrl;
}
