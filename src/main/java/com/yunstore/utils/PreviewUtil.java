package com.yunstore.utils;

import java.awt.image.BufferedImage;
import java.io.*;
import java.net.ConnectException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.zip.DataFormatException;

import javax.imageio.ImageIO;

import com.artofsolving.jodconverter.DocumentConverter;
import com.artofsolving.jodconverter.openoffice.connection.OpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.connection.SocketOpenOfficeConnection;
import com.artofsolving.jodconverter.openoffice.converter.OpenOfficeDocumentConverter;
import com.flagstone.transform.*;
import com.flagstone.transform.util.FSImageConstructor;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.PDFRenderer;  
  
public class PreviewUtil {

    /**
     * 转换文件成pdf
     * coc2HtmlUtil.file2pdf(fileInputStream, "/Users/tengyunhao","xls");
     */
    public static File office2PDF(File file, String out, String type) {
        String name = file.getName().substring(0,file.getName().lastIndexOf('.'));
        String docFileName = name + ".temp";
        String htmFileName = name + ".pdf";
        switch (type) {
            case "doc": docFileName += ".doc"; break;
            case "docx": docFileName += ".docx"; break;
            case "ppt": docFileName += ".ppt"; break;
            case "pptx": docFileName += ".pptx"; break;
            case "xls": docFileName += ".xls"; break;
            case "xlsx": docFileName += ".xlsx"; break;
        }

        File htmlOutputFile = new File(out + File.separatorChar + htmFileName);
        File docInputFile = new File(out + File.separatorChar + docFileName);

        if (htmlOutputFile.exists()) {
            htmlOutputFile.delete();
        }
        if (docInputFile.exists()) {
            docInputFile.delete();
        }
        try {
            htmlOutputFile.createNewFile();
            docInputFile.createNewFile();
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }

        /**
         * 由fromFileInputStream构建输入文件
         */
        try {
            OutputStream os = new FileOutputStream(docInputFile);
            InputStream is = new FileInputStream(file);
            int bytesRead = 0;
            byte[] buffer = new byte[1024 * 8];
            while ((bytesRead = is.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }

            os.close();
            is.close();
        } catch (Exception e) {
            return null;
        }

        OpenOfficeConnection connection = new SocketOpenOfficeConnection(8100);
        try {
            connection.connect();
        } catch (ConnectException e) {
            System.err.println("文件转换出错，请检查OpenOffice服务是否启动。");
            return null;
        }
        // convert
        DocumentConverter converter = new OpenOfficeDocumentConverter(connection);
        converter.convert(docInputFile, htmlOutputFile);
        connection.disconnect();
        // 转换完之后删除word文件
        docInputFile.delete();
        System.out.println(htmFileName);
        return htmlOutputFile;
    }

    /**
     * PDF转IMG
     * @param pdf PDF文件
     * @param out 输出路径
     */
    public static void PDF2IMG(File pdf, String out) {
        try {
            PDDocument doc = PDDocument.load(pdf);
            PDFRenderer renderer = new PDFRenderer(doc);
            int pageCount = doc.getNumberOfPages();
            String name = pdf.getName().substring(0,pdf.getName().lastIndexOf('.'));
            for (int i = 0; i < pageCount; i++) {
                // 方式1,第二个参数是设置缩放比(即像素)
                BufferedImage image = renderer.renderImageWithDPI(i, 296);
                // 方式2,第二个参数是设置缩放比(即像素)
                // BufferedImage image = renderer.renderImage(i, 2.5f);
                File img = new File(out+name+"/"+name+"_"+i+".png");
                img.mkdirs();
                ImageIO.write(image, "PNG", img);
            }
//            IMG2SWF(new File(out+name), out);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * IMG转PDF
     * @param img 图片文件夹（多个图片），或者图片绝对路径（单个图片）
     * @param out 输出路径
     */
    public static void IMG2SWF(final File img,final String out) {
        FSMovie movie = new FSMovie();
        int i = 1;
        for (File f : img.listFiles()) {
            //获取图片基本属性
            FSImageConstructor imageGenerator = null;
            try {
                imageGenerator = new FSImageConstructor(f.getAbsolutePath());
            } catch (IOException e) {
                e.printStackTrace();
            } catch (DataFormatException e) {
                e.printStackTrace();
            }
            //获取图片和画布id
            int imageId = movie.newIdentifier();
            int shapeId = movie.newIdentifier();
            //获取到图片格式
            FSDefineObject image = imageGenerator.defineImage(imageId);
            image.setIdentifier(imageId);
            imageGenerator.defineImage(imageId);
            //加入图片
            movie.add(image);
            //设置swf画布样式、位置
            FSDefineShape3 shape = imageGenerator.defineEnclosingShape(shapeId,imageId, 0, 0, new FSSolidLine(10, FSColorTable.white()));
            //加入swf模型
            movie.add(shape);
            //得到画布
            FSBounds bounds = shape.getBounds();
            //设置画布到容器
            movie.setFrameSize(bounds);
            //设置每张图片1秒一帧
            movie.setFrameRate(1F);
            //设置容器背景颜色
            movie.add(new FSSetBackgroundColor(FSColorTable.white()));
            //在每一帧上添加一个图片,并且设置上下距离为0
            movie.add(new FSPlaceObject2(shapeId, i, 0, 0));
            //显示动画
            movie.add(new FSShowFrame());
            i+=2;
        }
        //在每一帧上添加一个图片,并且设置上下距离为0，这个地方需要在Flash中最后多添加一帧加入空白帧，否则显示不正常。
        movie.add(new FSPlaceObject2(-1, i, 0, 0));
        //输出路径
        try {
            movie.encodeToFile(out+img.getName()+".swf");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}  