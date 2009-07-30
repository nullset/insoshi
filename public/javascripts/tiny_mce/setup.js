tinyMCE.init({
	// General options
	mode : "textareas",
	editor_deselector : "noTinyMCE",
	theme : "advanced",
	relative_urls : false,
	valid_elements : "@[id|class|style|title]|"
  + "a[rel|rev|charset|hreflang|tabindex|accesskey|type|"
  + "name|href|target|title|class],strong/b,em/i,strike,u,"
  + "#p[align],-ol[type|compact],-ul[type|compact],-li,br,img[longdesc|usemap|"
  + "src|border|alt=|title|hspace|vspace|width|height|align],-sub,-sup,"
  + "-blockquote,-table[border=0|cellspacing|cellpadding|width|frame|rules|"
  + "height|align|summary|bgcolor|background|bordercolor],-tr[rowspan|width|"
  + "height|align|valign|bgcolor|background|bordercolor],tbody,thead,tfoot,"
  + "#td[colspan|rowspan|width|height|align|valign|bgcolor|background|bordercolor"
  + "|scope],#th[colspan|rowspan|width|height|align|valign|scope],caption,-div,"
  + "-span,-code,-pre,address,-h1,-h2,-h3,-h4,-h5,-h6,hr[size|noshade],-font[face"
  + "|size|color],dd,dl,dt,cite,abbr,acronym,del[datetime|cite],ins[datetime|cite],"
  + "object[classid|width|height|codebase|*],param[name|value|_value],embed[type|width"
  + "|height|src|*],script[src|type],map[name],area[shape|coords|href|alt|target],bdo,"
  + "button,col[align|char|charoff|span|valign|width],colgroup[align|char|charoff|span|"
  + "valign|width],dfn,fieldset,form[action|accept|accept-charset|enctype|method],"
  + "input[accept|alt|checked|disabled|maxlength|name|readonly|size|src|type|value],"
  + "kbd,label[for],legend,noscript,optgroup[label|disabled],option[disabled|label|selected|value],"
  + "q[cite],samp,select[disabled|multiple|name|size],small,"
  + "textarea[cols|rows|disabled|name|readonly],tt,var,big",
	plugins : "safari,style,advimage,emotions,iespell,inlinepopups,preview,media,searchreplace,contextmenu,paste,fullscreen,noneditable,visualchars,xhtmlxtras",

	// Theme options
	theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,bullist,numlist,|,outdent,indent,blockquote,|,sub,sup",
	theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,undo,redo,|,link,unlink" + tinyMCE_media_buttons + ",emotions,charmap,iespell,code,|,preview",
	theme_advanced_buttons3 : "",
	theme_advanced_toolbar_location : "top",
	theme_advanced_toolbar_align : "left",
	theme_advanced_statusbar_location : "bottom",
	theme_advanced_resizing : true,

	// Example content CSS (should be your site CSS)
	content_css : "/stylesheets/tiny_mce.css",

  // Drop lists for link/image/media/template dialogs
  external_image_list_url : tinyMCE_images_path

});