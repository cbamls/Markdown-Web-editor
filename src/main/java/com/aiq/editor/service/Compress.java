package com.aiq.editor.service;

import net.coobird.thumbnailator.Thumbnails;

import java.io.File;
import java.io.IOException;

public class Compress {
    public static void main(String[] args) throws IOException {
        File from = new File("/Users/liangshu/Downloads/test.jpeg");
        File to = new File("/Users/liangshu/Downloads/output.jpeg");

        Thumbnails.of(from).scale(1f).outputQuality(0.1f).toFile(to);
    }
}
