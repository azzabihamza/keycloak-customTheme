<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
    <div id="kc-form">
        <#if messagesPerField.existsError('username','password')>
            <div id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                <img src="${url.resourcesPath}/img/error.svg" />
                <div class="error-message">
                    <span id="error-title">Erreur</span>
                    <span id="msg" >Veuillez vérifier vos paramètres d’accès  </span>
                </div>
                <#--  ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}  -->
            </div>
        </#if>
      <div id="kc-form-wrapper">
        <#if realm.password>
            <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <#if !usernameHidden??>
                    <div class="${properties.kcFormGroupClass!}" id="email-formgroup">
                        <label for="username" class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("E-mail")}</#if></label>

                        <input tabindex="1" id="username" class="<#if messagesPerField.existsError('username','password')> ${properties.kcInputErrorClass!} <#else> ${properties.kcInputClass!} </#if>  " name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off" placeholder="Entrer votre email"
                               aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                        />  

                       

                    </div>
                </#if>

                <div class="${properties.kcFormGroupClass!}">
                    <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                    <div id="input-group-password">
                        <input tabindex="2" id="password" class="<#if messagesPerField.existsError('username','password')> ${properties.kcInputErrorClass!} <#else> ${properties.kcInputClass!} </#if>" name="password" type="password" autocomplete="off" placeholder="Entrer votre mot de passe"
                            aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                        />
                        <span id="togglePassword"  toggle="#password-field" onclick="showHide();" class="fa fa-fw fa-eye field-icon toggle-password"></span>
                        
                    </div>
                    <#if usernameHidden?? && messagesPerField.existsError('username','password')>
                        <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </span>
                    </#if>

                </div>

                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                    <div id="kc-form-options">
                        <#if realm.rememberMe && !usernameHidden??>
                            <div class="checkbox">
                                <label>
                                    <#if login.rememberMe??>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}
                                    <#else>
                                        <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> ${msg("rememberMe")}
                                    </#if>
                                </label>
                            </div>
                        </#if>
                        </div>
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                            <#if realm.resetPasswordAllowed>
                                <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("Mot de passe oublié ?")}</a></span>
                            </#if>
                        </div>

                  </div>

                  <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                      <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                      <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("Se connecter")}"/>
                  </div>
            </form>
        </#if>
        </div>

    </div>
    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration-container">
                <div id="kc-registration">
                    <span>${msg("noAccount")} <a tabindex="6"
                                                 href="${url.registrationUrl}">${msg("doRegister")}</a></span>
                </div>
            </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <#--  <hr/>  -->
                <#--  <h4>${msg("identity-provider-login-label")}</h4>  -->

                <#--  <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">  -->
                    <#list social.providers as p>
                        <a id="social-google" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <#--  <span class="${properties.kcFormSocialAccountNameClass!}">
                                    ${p.displayName!}
                                </span>  -->
                                <img src="${url.resourcesPath}/img/outlook.svg" />
                                <span class="kc-social-icon-text">Se connecter avec Outlook</span>
                            </#if>
                        </a>
                    </#list>
                <#--  </ul>  -->
            </div>
        </#if>
    </#if>
 
</@layout.registrationLayout>
