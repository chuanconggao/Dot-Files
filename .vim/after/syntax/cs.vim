syn keyword csType bool byte char decimal double float int long object sbyte short string uint ulong ushort void var
syn keyword csUsing using
syn keyword csAsync async await

syn match csOperator display "[?:]"
syn match csOperator display "[-+\*/%=]"
syn match csOperator display "[!<>]=\="
syn match csOperator display "=="
syn match csOperator display "\(&\||\|\^\|<<\|>>\)=\="
syn match csOperator display "\~"
syn match csOperator display "&&\|||"

syn match csSpecialOperator display "[\[\]\(\){}]"
syn match csSpecialOperator display "\."

syn match csLineEnd ";\|,"

hi def link csUsing PreProc
hi def link csLineEnd LineEnd
hi def link csOperator Operator
hi def link csSpecialOperator Special
hi def link csOperatorError Error

" Comments
"
" PROVIDES: @csCommentHook
"
" TODO: include strings ?
"
syn keyword csTodo		contained TODO FIXME XXX NOTE
syn region  csComment		start="/\*"  end="\*/" contains=@csCommentHook,csTodo,@Spell
syn match   csComment		"//.*$" contains=@csCommentHook,csTodo,@Spell

" xml markup inside '///' comments
syn cluster xmlRegionHook	add=csXmlCommentLeader
syn cluster xmlCdataHook	add=csXmlCommentLeader
syn cluster xmlStartTagHook	add=csXmlCommentLeader
syn keyword csXmlTag		contained Libraries Packages Types Excluded ExcludedTypeName ExcludedLibraryName
syn keyword csXmlTag		contained ExcludedBucketName TypeExcluded Type TypeKind TypeSignature AssemblyInfo
syn keyword csXmlTag		contained AssemblyName AssemblyPublicKey AssemblyVersion AssemblyCulture Base
syn keyword csXmlTag		contained BaseTypeName Interfaces Interface InterfaceName Attributes Attribute
syn keyword csXmlTag		contained AttributeName Members Member MemberSignature MemberType MemberValue
syn keyword csXmlTag		contained ReturnValue ReturnType Parameters Parameter MemberOfPackage
syn keyword csXmlTag		contained ThreadingSafetyStatement Docs devdoc example overload remarks returns summary
syn keyword csXmlTag		contained threadsafe value internalonly nodoc exception param permission platnote
syn keyword csXmlTag		contained seealso b c i pre sub sup block code note paramref see subscript superscript
syn keyword csXmlTag		contained list listheader item term description altcompliant altmember

syn cluster xmlTagHook add=csXmlTag

syn match   csXmlCommentLeader	+\/\/\/+    contained
syn match   csXmlComment	+\/\/\/.*$+ contains=csXmlCommentLeader,@csXml,@Spell
syntax include @csXml syntax/xml.vim
hi def link xmlRegion Comment
